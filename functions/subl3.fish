# This is my "open this folder for programming" command.
#
# This is called `subl3` because of ancient muscle memory (going back to when I
# used Sublime Text, but `subl` referred to Sublime Text 2, since ST3 was still
# beta...)
#
# In principal this is an alias for `code`, but tries to automatically open the
# `blah.code-workspace` in the folder in some situations. Specifically:
#
# - If theres 1 argument passed in.
# - If that argument doesn't start with `-`, and happens to be a directory.
# - If that directory has a single `blah.code-workspace` file in its root.
#
# Then we'll open that instead. Note that this can be worked around by
# `subl3 -- <path>`, which will cause the first condition to fail.
function subl3 --description 'alias subl3=code'
	set -l args $argv
	if set -q argv[1] && not set -q argv[2] && test -d "$argv[1]" && not string match -q -- '-*' "$argv[1]"
		set -l workspaces "$argv[1]"/*.code-workspace
		if set -q workspaces[1] && not set -q workspaces[2]
			printf "%snote: opening workspace at `%s` instead (disable with `subl3 -- ...`)%s" (set_color --dim) "$workspaces[1]" (set_color normal) >&2
			set args $workspaces[1]
		end
	end
	code $args
end
