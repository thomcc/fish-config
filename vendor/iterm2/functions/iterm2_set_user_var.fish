# Usage: iterm2_set_user_var key value
# These variables show up in badges (and later in other places). For example
# iterm2_set_user_var currentDirectory "$PWD"
# Gives a variable accessible in a badge by \(user.currentDirectory)
# Calls to this go in iterm2_print_user_vars.
function iterm2_set_user_var -a key -a value
    if test "$ITERM_INTEGRATION" = 1
        printf "\033]1337;SetUserVar=%s=%s\007" "$key" (printf "%s" "$value" | base64 | tr -d "\n")
    end
end
