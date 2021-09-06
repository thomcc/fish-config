if test -d "$HOME/.nvm"
    function __tcsc_ensure_nvm_initialized
        if not set -q __tcsc_nvm_initialized
            nvm use default >/dev/null 2>/dev/null
            set -g __tcsc_nvm_initialized 1
        end
    end
    function node
        __tcsc_ensure_nvm_initialized
        command node $argv
    end
    function npm
        __tcsc_ensure_nvm_initialized
        command npm $argv
    end
    function npx
        __tcsc_ensure_nvm_initialized
        command npx $argv
    end
end
