function rlr
    set -l rust_dir
    if set -q RUST_LANG_RUST_REPO
        set rust_dir $RUST_LANG_RUST_REPO
    else if test -d "$HOME/src/rust/.git"
        set rust_dir "$HOME/src/rust"
    else if test -d "$HOME/scratch/rust/.git"
        set rust_dir "$HOME/scratch/rust"
    else
        echo "I don't know where the rust checkout is. Try `set -U RUST_LANG_RUST_REPO /path/to/repo/here"
        exit 1
    end
    cd "$rust_dir"
    set -l subl3_arg .
    for wsfile in *.code-workspace
        set subl3_arg $wsfile
        break
    end
    subl3 "$subl3_arg"
end
