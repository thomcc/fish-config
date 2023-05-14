if command -q cargo && command -q op
    function cargo
        set -lx OP_PLUGIN_ALIASES_SOURCED 1
        op plugin run -- cargo $argv
    end
end
