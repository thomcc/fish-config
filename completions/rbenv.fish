if command -sq rbenv
    # rbenv sources its completions on init, and we set things up so that
    # that happens on the first call.
    rbenv --version >/dev/null 2>/dev/null
end
