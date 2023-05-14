bind \e\[1\;6D backward-word
bind \e\[1\;6C forward-word
bind \u2202 delete-char
# Don't judge me.
complete -c subl3 -w code
# if command -sq hub
#     alias git=hub
# end

if test "$TERM_PROGRAM" = iTerm.app && not string match -q -- 'eterm*' "$TERM"
    set -gx fish_emoji_width 2
end

if test -n "$XTERM_VERSION"
    set -gx LC_CTYPE en_US.UTF-8
    set -gx LC_ALL en_US.UTF-8
    set -gx LANG en_US.UTF-8
    set -l xtver (string sub --start 7 --end -1 -- "$XTERM_VERSION")
    if string match -qr "[0-9]{3}" -- "$xtver" && test "$xtver" -gt "360"
        set -gx TERM "xterm-direct"
    end
    #set -g NOICONFONT 1
end

if string match -q "* mono" "$ITERM_PROFILE"
    set -g NOICONFONT mono
end

# `set -U THIS_MACHINE_NEEDS_GPG_TTY 1` to enable this annoying hack.
if test "$THIS_MACHINE_NEEDS_GPG_TTY"
    set -gx GPG_TTY (tty)
end

if test "Darwin" = "$(uname -s)"
    if not contains -- "/usr/local/bin" $PATH
        set PATH $PATH "/usr/local/bin"
    end
end
