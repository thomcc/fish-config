complete -xc target -d "print rust target info" -a '(__target_targets)'
complete -c target -s l -l list -d "print target list"
complete -c target -l no-json -d "don't dump target json"
complete -c target -l no-cfg -d "don't dump cfg"
complete -c target -s j -l only-json -d "only dump target json"
complete -c target -s c -l only-cfg -d "only dump cfg"
complete -c target -s B -l no-bootstrap -d "don't set RUSTC_BOOTSTRAP ever"
set -l toolchains nightly beta stable '+nightly' '+beta' '+stable'

function __target_targets
    rustc +nightly --print=target-list
end

function __target_toolchains
    set -l all (rustup toolchain list | string replace -r "\s+.*" '' | string replace -r '[-].+' '' | sort -ur)
    echo "+nightly"
    echo "+stable"
    for t in $all
        # echo "$t"
        if test "$t" != "nightly" && test "$t" != "stable"
            echo "+$t"
        end
    end
end

complete -xc target -s t -l toolchain -d "set toolchain" -a '(__target_toolchains)'


# complete -c cargo -x -n "__cargo_seen_subcommand_from bench build check clippy clean doc fix install package publish run rustc rustdoc test" -l target -d 'Build for the target triple' -a '(rustup target list --installed)'

# complete -c target -s r -l rule -d "Set input validation <regex>"
# complete -c target -s e -l error -d "Set the error <message>"
# complete -c target -l no-cursor -d "Hide cursor"
# complete -c target -l no-case -d "Ignore case during validation"
# complete -c target -s s -l silent -d "Hide user input as it is typed"
# complete -c target -s q -l quiet -d "Enable quite mode"
# complete -c target -s h -l help -d "Show usage help"
