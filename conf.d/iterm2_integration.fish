# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

# Note: heavily modified version of the default.

if not set -q DISABLE_ITERM_INTEGRATION &&
    test "$TERM_PROGRAM" = "iTerm.app" &&
    string match -qr '^(eterm|dumb|linux$)' -- "$TERM"

    if status --is-interactive && not string match -qr '^screen(-256color)?$' -- "$ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX$TERM"
        # full integration
        set -gx ITERM_INTEGRATION 1
    else
        # partial integration
        set -gx ITERM_INTEGRATION
    end
else
    set --erase ITERM_INTEGRATION
end

if set -q ITERM_INTEGRATION
    set -l dir (status dirname)
    set -l datadir (realpath "$dir/../vendor/iterm2/bin")
    set -l funcdir (realpath "$dir/../vendor/iterm2/functions")
    if not test -d "$datadir" && test -d "$HOME/.config/fish/vendor/iterm2/bin"
        set datdir "$HOME/.config/fish/vendor/iterm2/bin"
    end
    if test -d "$datadir"
        fish_add_path -aP "$datadir"
    end
    if test -d "$funcdir" && \
            not functions -q iterm2_set_user_var && \
            not contains "$funcdir" $fish_function_path
        set -a fish_function_path "$funcdir"
    end
end

if test "$ITERM_INTEGRATION" = "1" && not functions -q -- iterm2_preexec

    # Tell terminal to create a mark at this location
    function iterm2_preexec --on-event fish_preexec
        # For other shells we would output status here but we can't do that in fish.
        printf "\033]133;C;\007"
    end

    # If hostname -f is slow for you, set iterm2_hostname before sourcing this script
    if not set -q -g iterm2_hostname
        # hostname -f is fast on macOS so don't cache it. This lets us get an updated version when
        # it changes, such as if you attach to a VPN.
        if [ (uname) != Darwin ]
            set -g iterm2_hostname (hostname -f 2>/dev/null)
            # some flavors of BSD (i.e. NetBSD and OpenBSD) don't have the -f option
            if test $status -ne 0
                set -g iterm2_hostname $hostname
            end
        end
    end

    iterm2_write_remotehost_currentdir_uservars
    printf "\033]1337;ShellIntegrationVersion=17;shell=fish\007"
end
