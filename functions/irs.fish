# Defined in - @ line 1
function irs --description 'alias irs=evcxr'
	set -lx RUSTC_BOOTSTRAP 1
	evcxr  $argv;
end
