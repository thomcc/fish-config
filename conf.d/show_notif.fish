if type -q osascript && string match -qr '^(Terminal.app|iTerm.app|vscode)$' -- "$TERM_PROGRAM"
    function show_notif --on-event fish_postexec
        set -l duration "$CMD_DURATION"
        set -l cmd $argv

        set -l notify_threshold_ms $NOTIFY_THRESHOLD_MS
        if not set -q notify_threshold_ms[1]
            set notify_threshold_ms 10000
        end

        if test "$duration" -gt "$notify_threshold_ms"
            set -l app
            set -l bundle
            switch "$TERM_PROGRAM"
                case 'iTerm.app'
                    set app iTerm
                    set bundle com.googlecode.iterm2
                case 'Terminal.app'
                    set app Terminal
                    set bundle com.apple.Terminal
                case 'vscode'
                    set app Code
                    set bundle com.microsoft.VSCode
                case '*'
                    # Shouldn't be possible.
                    return 1
            end
            set -l is_front (osascript -e "tell application \"$app\" to frontmost")
            if test "$is_front" = "false"
                set -l cmdstr "$cmd"
                # avoid a massive command... Think more about this...
                # if test 30 -lt (string length $cmdstr)
                #     set cmdstr (string trim -c 27 -- $cmdstr)"..."
                # end
                set -l message "Command `$cmdstr` finished running after $(math $duration / 1000)s"

                if test "$TERM_PROGRAM" = "iTerm.app" && not string match -qr '[[:cntrl:]]' -- "$cmdstr"
                    printf "\033]9;%s\007" "$message"
                else if type -q terminal-notifier
                    terminal-notifier -activate "$bundle" \
                        -title "Command finished" \
                        -message "Command `$cmdstr` finished running after "(math $duration / 1000)"s"
                else
                    # avoid bustage when cmdstr has quotes or escapes
                    # applescript doesn't like
                    if string match -qr '["\\\\]' -- "$cmdstr"
                        set cmdstr (string replace -r '^(.*?)["\\\\].*$' '$1...' -- "$cmdstr")
                    end
                    osascript -e "display notification \"Command `$cmdstr` finished running after "(math $duration / 1000)"s\" with title \"Command finished\""
                end
            end
        end
    end
end
