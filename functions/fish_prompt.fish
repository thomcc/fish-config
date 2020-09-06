

function fish_prompt -d 'Write out the prompt'
  __tcsc_do_prompt -l \
    __tcsc_prompt_status \
    __tcsc_prompt_cwd \
    __tcsc_prompt_git

  # set_color -b aaa
  # printf "%s%s%s%s" (set_color -b aaa) '\e[K\n' (set_color FF7676) "❯ "
end
