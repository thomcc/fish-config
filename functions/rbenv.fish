if command -sq rbenv && status --is-interactive
    source (rbenv init -|psub)
end
