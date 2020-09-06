function cdir -a dir -d 'Combination of "mkdir -p <dir>" and "cd <dir>"'
    mkdir -p $dir
    cd $dir
end
