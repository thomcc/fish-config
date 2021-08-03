# I mainly use vscode, which I have aliased to `subl3` for (awful) historical
# reasons / muscle memory. However, I still occasionally use Sublime Text,
# mostly for very big files I don't need to edit extensively (for example,
# `miniaudio` has a 60kloc header file, and vscode just dies on it, but Sublime
# handles it like a champ).
#
# Putting `subl` it on my PATH would break tab completion for `subl3` (yes, I
# should develop muscle memory for `code`, but... I have no intention of doing
# so) so instead, I alias `sbl` (which doesn't collide at all with `subl3` in
# the autocomplete) to the binary directly.
#
# I first check the canonical location (at least, on the OSes where I use
# `fish`), then fallback to using `subl` if it's actually on the path.
if test -x "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
    # macOS. The extra \ is needed to avoid `Text.app/...` being seen as an
    # argument to `/Applications/Sublime`, even though we don't need (or want)
    # it above.
    alias sbl "/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
else if test -x /opt/sublime_text/sublime_text
    # linux, plausibly other unix
    alias sbl /opt/sublime_text/sublime_text
else if command -q subl
    # Already on PATH. Check if it's actually Sublime Text, since it might just
    # be another alias for `code` (...look, don't judge me). We do this in a
    # couple steps to ignore any errors a bit more effectively.
    if set -l version_text (command subl -v 2> /dev/null)
        if string match -qr '^Sublime Text' -- "$version_text"
            alias sbl 'command subl'
        end
    end
end
