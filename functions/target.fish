function target
    # set -l argv
    set -l toolchain
    if string match -q '+*' -- "$argv[1]"
        set toolchain "$argv[1]"
        set -e argv[1]
    end
    set -l set_bootstrap
    set -l rustc_v_out (rustc $toolchain --version 2>/dev/null)
    if not string match -qr "nightly|dev" -- "$rustc_v_out"
        set -fx RUSTC_BOOTSTRAP 1
        set set_bootstrap 1
    end
    set -l nargs (count $argv)
    set -l rest
    set -l json 1
    set -l cfg 1
    set -l skip_next
    set -l any
    set -l flags -Zunstable-options $RUSTFLAGS
    # set -l targets (rustc $toolchain --print=target-list)
    if test (count $argv) -lt 1
        if set -l host (rustc $toolchain -vV | string replace -fr 'host: ' '')
            rustc $toolchain --print=target-spec-json "--target=$host" $flags | jq
        end
        rustc $toolchain --print=cfg $flags | bat --language=toml
        # echo "NO ARGS"
        return
        # set any 1
    else
        for i in (seq 1 $nargs)
            if set -q skip_next[1]
                set -e skip_next
                continue
            end
            set -l arg "$argv[$i]"
            # echo "$i: $arg"
            switch $arg
                case '--list' '-l' 'list'
                    rustc $toolchain --print=target-list $flags
                    return
                case '-h' '--help' 'help'
                    printf "Usage: target [(-l | --list | list)] [--no-json] [--no-cfg] [--only-json] [--only-cfg]\n"
                    printf "           [(-B | --no-bootstrap)] [(-t | --toolchain) +toolchain]\n"
                    printf "           [-Cfoo=bar...] [-Zbaz-quux...] [--]\n"
                    printf "           [TARGETS...]\n\n"
                    return
                case '-t' '--toolchain'
                    set toolchain $argv[(math $i + 1)]f
                    if set -q toolchain[1] && not string match -q '+*' -- $toolchain
                        set toolchain "+$toolchain"
                    end
                    set skip_next 1
                case '-t=*' '--toolchain=*'
                    set toolchain (string replace -r '^.*?=[+]?' '' -- $arg)
                    set toolchain '+$toolchain'
                case '--'
                    set -a rest $argv[(math $i + 1)..-1]
                    break
                case '-B' '--no-bootstrap'
                    if test "$set_bootstrap" = 1
                        set -e RUSTC_BOOTSTRAP
                    end
                case '-j' '--json' '--json-only' '--only-json'
                    set json 1
                    set cfg 0
                case '--no-json'
                    set json 0
                case '-c' '--cfg' '--cfg-only' '--only-cfg'
                    set cfg 1
                    set json 0
                case '--no-cfg'
                    set cfg 0
                    # case '--cfg'
                    #     set cfg 1
                case '-C' '-Z' '--codegen'
                    # echo "Warning: Please use -Cfoo or -Zfoo=bar not -C foo / -Z foo=bar"
                    set -a flags "$arg" $argv[(math $i + 1)]
                    set skip_next 1
                case '-C*' '-Z*'
                    set -a flags "$arg"
                case '-*'
                    echo "Warning: unknown option '$arg' in `$argv`"
                case '*'
                    set any 1
                    echo "Dumping info for target '$arg'"
                    if test "$json" = "1"
                        rustc $toolchain --print=target-spec-json "--target=$arg" $flags | jq
                    end
                    if test "$cfg" = "1"
                        rustc $toolchain --print=cfg "--target=$arg" $flags | bat --language=toml
                    end
            end
        end
    end

    for a in $rest
        if test "$a" = "--"
            continue
        end
        echo "Dumping info for target '$a'"
        if test "$json" = "1"
            rustc $toolchain --print=target-spec-json "--target=$arg" $flags | jq
        end
        if test "$cfg" = "1"
            rustc $toolchain --print=cfg "--target=$arg" $flags | bat --language=toml
        end
        set any 1
    end
    if test "$any" != "1"
        if test "$json" = "1"
            if set -l host (rustc $toolchain -vV | string replace -fr 'host: ' '')
                rustc $toolchain --print=target-spec-json "--target=$host" $flags | jq
            end
        end
        if test "$cfg" = "1"
            rustc $toolchain --print=cfg $flags | bat --language=toml
        end
    end
end
