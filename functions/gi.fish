# Defined in /var/folders/hz/xc4s0xgn3g7f59l5m_yqh8c80000gn/T//fish.kUfxlT/gi.fish @ line 1
function gi --description 'list all files in directory'
    set -l args (string join ',' $argv)
    command curl -fL "https://www.gitignore.io/api/$args"
end
