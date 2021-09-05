function cat --description 'alias cat=bat'
    if set -q argv[1] && test -d $argv[1]
        exa -lah $argv
    else
        bat $argv
    end
end
