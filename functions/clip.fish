# Defined in - @ line 1
function clip --description 'alias clip=cargo clip'
	if set -l maybeplus (string sub -l 1 $argv[1]); and test "$maybeplus" = "+"
		cargo $argv[1] clippy --all-targets --all-features --all $argv[2..-1]
	else
		cargo clippy --all-targets --all-features --all $argv
	end
end
