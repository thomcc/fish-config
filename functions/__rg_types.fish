# TODO: still works?
function __rg_types
    for item in (rg --type-list)
        if set -l match (string match -r '^(.*?)\:\s*(.*?)$' -- "$item")
            set -l name $match[2]
            set -l val $match[3]
            set -l spl (string split ', ' -- "$val")
            if test (count $spl) -gt 4
                set val (string join ', ' -- $spl[1..3])
                set val "$val, ..."
            end
            echo "$name"\t"$val"
        end
    end
end