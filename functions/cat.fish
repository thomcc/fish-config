function cat --description 'alias cat=bat'
    if test -d $argv[1]
        exa -lah $argv
    else
        bat $argv
    end
end
