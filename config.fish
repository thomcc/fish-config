
nvm use default >/dev/null 2>/dev/null &
#sccache --start-server >/dev/null 2>/dev/null &
if test "$TERM_PROGRAM" = iTerm.app; and not string match -q -- 'eterm*' "$TERM"
    test -e {$HOME}/.iterm2_shell_integration.fish
    and source {$HOME}/.iterm2_shell_integration.fish
end

bind \e\[1\;6D backward-word
bind \e\[1\;6C forward-word
bind \u2202 delete-char
# Don't judge me.
complete -c subl3 -w subl

alias git=hub

if command -sq rbenv && status --is-interactive
    source (rbenv init -|psub)
end

wait

if test "$TERM_PROGRAM" = iTerm.app && not string match -q -- 'eterm*' "$TERM"
    set -gx fish_emoji_width 2
end

if test -n "$XTERM_VERSION"
    set -gx LC_CTYPE en_US.UTF-8
    set -gx LC_ALL en_US.UTF-8
    set -gx LANG en_US.UTF-8
    #set -g NOICONFONT 1
end
