function fish_right_prompt
  if not string match -q -- 'eterm*' "$TERM" && test "$XTERM_LOCALE" != "C"
    __tcsc_do_prompt -r \
      __tcsc_prompt_rust \
      __tcsc_prompt_duration \
      __tcsc_prompt_hostname
  end
end
