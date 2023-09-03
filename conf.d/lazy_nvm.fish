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
    if set -l nvm_default (cat "$HOME/.nvm/alias/default" 2> /dev/null)
        set -l nvm_default_bindir "$HOME/.nvm/versions/node/$nvm_default/bin"
        if test -d "$nvm_default_bindir"
            if test -x "$nvm_default_bindir/foam"
                function foam
                    __tcsc_ensure_nvm_initialized
                    command foam $argv
                end
            end
            if test -x "$nvm_default_bindir/tsc"
                function tsc
                    __tcsc_ensure_nvm_initialized
                    command tsc $argv
                end
            end
            # set -l aliased tsc pnpm pnmx yo 'yo-complete' tsserver foam tslint
            # for name in $aliased
            #     if not type -q $name
            #         echo "function $name; __tcsc_ensure_nvm_initialized; command $name \$argv; end" | source
            #     end
            # end
        end
    end
    # set -l ~/.nvm/versions/node/$(cat ~/.nvm/alias/default )/bin
    # ~/.nvm/versions/node/$(cat ~/.nvm/alias/default )/bin
end
