# Defined in /var/folders/ht/wbyj87v94tqgt_49q90ss_sh0000gn/T//fish.8TtoBu/lldb.fish @ line 2
function lldb --description 'alias lldb=PATH="/usr/bin:"(string join : -- $PATH) lldb'
	env PATH="/usr/bin:"(string join ':' -- $PATH) lldb $argv;
end
