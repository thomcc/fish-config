function fish_right_prompt
  if not string match -q -- 'eterm*' "$TERM"
  # && test -z "$XTERM_VERSION"
    __tcsc_do_prompt -r \
      __tcsc_prompt_rust \
      __tcsc_prompt_duration
  end
end
