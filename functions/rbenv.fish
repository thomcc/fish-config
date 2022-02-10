if command -sq rbenv && status --is-interactive
    rbenv init - | source
    # source (rbenv init -|psub)
end
