function mp3sizes --argument d
    pushd $d
    for dir in (ls .)
        set -l found
        for file in "$dir"/*.mp3
            if set -l br (mpck "$file" | grep 'bitrate')
                set br (string replace -r '(average)? bitrate' '' -- $br | string trim)
                printf "%s \t## %s\n" "$dir" "$br"
                set found 1
                break
            end
        end
        if test "$found" != "1"
            printf "\n%s \t\a## ???\n" "$dir"
        end
    end
    popd
end
