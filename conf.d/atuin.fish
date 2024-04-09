if command -q atuin
    if status is-interactive
        atuin init fish | source
    end
end
