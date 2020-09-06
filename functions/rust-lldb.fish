# Defined in /var/folders/ht/wbyj87v94tqgt_49q90ss_sh0000gn/T//fish.pNr7FP/rust-lldb.fish @ line 2
function rust-lldb --description 'alias rust-lldb=PATH="/usr/bin:"(string join : -- $PATH) rust-lldb'
	env PATH="/usr/bin:"(string join ':' -- $PATH) rust-lldb $argv;
end
