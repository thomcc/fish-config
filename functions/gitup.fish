
function gitup
    set -l here (pwd | string replace "$HOME" "~")
    set -l loginfo (printf "\e[36;2m[\e[96;1minfo\e[36;22;2m@\e[22m%s\e[36;2m]:\e[m" "$here")
    set -l logwarn (printf "\e[33;2m[\e[93;22;1mwarn\e[33;22;2m@\e[22m%s\e[33;2m]:\e[m" "$here")
    set -l logerr (printf "\e[31;2m[\e[91;22;1mfail\e[31;22;2m@\e[22m%s\e[31;2m]:\e[m" "$here")
    if not test -d ./.git
        echoerr "$logerr not in a gitrepo? unsure."
        return 1
    end
    if set -l newurl (git remote get-url origin | string replace -r '^git://github.com/' 'git@github.com:')
        echoerr "$loginfo updating origin url to `$newurl`"
        if git remote set-url origin "$newurl"
            echoerr "$loginfo seems good!"
            if not git remote update
                echoerr "$logwarn didn't quite work. oh well, can't win 'em all"
            else
                echoerr "$loginfo another satisfied customer. next!"
            end
        else
            echoerr "$logerr appears to have failed!"
            return 1
        end
    else
        echoerr "$loginfo seems like its already fine."
    end
end

# function gitup
#     if not set -q argv[1]
#     for repo in $args
#         cd "$repo"
#         if gitup_pwd
#             echo "PASS: $repo"
#             echoerr "\e[2mPASS ($repo)\e[m"
#         else
#             echo "FUCK: $repo"
#             echoerr "\e[1mFUCK ($repo)\e[m"
#         end
#         cd -
#     end
# end
