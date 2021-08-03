# Note: Heavily modified version of https://github.com/radek-sprta/powerfish

# Characters
if not set -q __tcsc_characters_initialized
    set -U __tcsc_characters_initialized
    set -U AHEAD \uf062
    set -U BEHIND \uf063
    set -U BRANCH \ue725
    set -U CONFLICTED \uf00d
    set -U DETACHED \ue729
    set -U FAILED '✘'
    set -U JOBS \uf423
    set -U MODIFIED \uf459
    set -U STAGED \uf457
    set -U UNTRACKED \uf474
    set -U SEPARATORS '' '' '' ''
    #set -U SEPARATORS ' ' ' '  ' ' ' '
end

function __tcsc_colors_default -d 'Set default color theme'
    # set -l cur_color_version 2
    # if test "$tcsc_color_version" != "$cur_color_version"
    set -q tcsc_color_bg_normal; or set -g tcsc_color_bg_normal 444
    set -q tcsc_text_light; or set -g tcsc_text_light white
    set -q tcsc_text_dark; or set -g tcsc_text_dark black
    set -q tcsc_color_cwd; or set -g tcsc_color_cwd 89c294 # 7963e6
    set -q tcsc_color_failed; or set -g tcsc_color_failed red
    set -q tcsc_color_jobs; or set -g tcsc_color_jobs $tcsc_text_light
    set -q tcsc_color_root; or set -g tcsc_color_root red
    set -q tcsc_color_remote; or set -g tcsc_color_remote yellow
    set -q tcsc_color_user; or set -g tcsc_color_user $tcsc_color_bg_normal
    set -q tcsc_color_venv; or set -g tcsc_color_venv magenta
    set -q tcsc_color_git_clean; or set -g tcsc_color_git_clean b090c5
    set -q tcsc_color_git_conflict; or set -g tcsc_color_git_conflict red
    set -q tcsc_color_git_dirty; or set -g tcsc_color_git_dirty yellow
    set -q tcsc_color_time; or set -g tcsc_color_time brblack
    set -q tcsc_color_time_slow; or set -g tcsc_color_time_slow b84a3e
    set -q tcsc_color_rust_version; or set -g tcsc_color_rust_version d8a1e5
    # end
end

function __tcsc_init_icons
    if test "$NOICONFONT" != ""
        set -g tcsc_icon_ahead "↑"
        set -g tcsc_icon_behind "↓"
        set -g tcsc_icon_branch ""
        set -g tcsc_icon_conflicted "✘"
        set -g tcsc_icon_detached "[D]"
        set -g tcsc_icon_failed "[E]"
        set -g tcsc_icon_jobs "[J]"
        set -g tcsc_icon_modified "⊡"
        set -g tcsc_icon_staged "⊞"
        set -g tcsc_icon_untracked "⧄"
        # set -g tcsc_icon_bug "[Bug]"
        # set -g tcsc_icon_rust "🦀"
        set -g tcsc_icon_rust '[R]'
    else
        set -g tcsc_icon_ahead "$AHEAD$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_behind "$BEHIND$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_branch "$BRANCH$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_conflicted "$CONFLICTED$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_detached "$DETACHED$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_failed "$FAILED$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_jobs "$JOBS$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_modified "$MODIFIED$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_staged "$STAGED$tcsc_prompt_icon_pad__"
        set -g tcsc_icon_untracked "$UNTRACKED$tcsc_prompt_icon_pad__"
        # set -g tcsc_icon_firefox \uf269
        # set -g tcsc_icon_bug \uf188
        # set -g tcsc_icon_rust "🦀"
        set -l rust_special \ue7a8
        set -g tcsc_icon_rust "$rust_special$tcsc_prompt_icon_pad__"
    end
end

# Prompt builders
function __tcsc_prompt_segment -d 'Draw prompt segment' -a head fg bg
    if test "$tcsc_prompt_dir" = l
        if not set -q tcsc_prompt_head
            set -g tcsc_prompt_head $head
            set_color $fg -b $bg
        else
            if test "$tcsc_current_background" != "$bg"
                printf "%s%s%s" (set_color $tcsc_current_background -b $bg) $tcsc_separator_full (set_color $fg -b $bg)
            else
                printf "%s%s" (set_color $fg -b $bg) $tcsc_separator_thin
            end
        end
    else
        if not set -q tcsc_prompt_head
            set -g tcsc_prompt_head $head
            printf "%s%s%s" (set_color $bg) $tcsc_separator_full (set_color $fg -b $bg)
        else
            if test "$tcsc_current_background" != "$bg"
                printf "%s%s%s" (set_color $bg) $tcsc_separator_full (set_color $fg -b $bg)
            else
                printf "%s%s" (set_color $fg -b $bg) $tcsc_separator_thin
            end
        end
    end
    set -g tcsc_current_background $bg
end

function __tcsc_prompt_end -d 'End the prompt'
    if test "$tcsc_prompt_dir" = l
        printf "%s " (__tcsc_prompt_segment "" normal normal)
    else
        set_color normal -b normal
    end
    set -e tcsc_prompt_head
    set -e tcsc_prompt_dir
end

function __tcsc_remove_count -d 'Remove count'
    printf "%s" (string replace -ar ' [0-9]' '' $argv[1])
end

function __tcsc_prompt_status
    __tcsc_prompt_last_status
    __tcsc_prompt_jobs
end
function __tcsc_prompt_last_status
    if test "$tcsc_last_status" -ne 0
        __tcsc_prompt_segment status $tcsc_text_dark $tcsc_color_failed
        printf " [%s] " "$tcsc_last_status"
    end
end

function __tcsc_prompt_jobs
    set -l bg_jobs (jobs | wc -l | string trim)
    if test "$bg_jobs" -gt 0
        __tcsc_prompt_segment jobs $tcsc_text_dark $tcsc_color_jobs
        if test "$bg_jobs" -gt 1
            printf "%s ×%s " $tcsc_icon_jobs $bg_jobs
        else
            printf "%s " $tcsc_icon_jobs
        end
    end
end

function __tcsc_prompt_venv -d "Write out virtual environment prompt"
    # Do nothing if not in virtual environment
    if test -n "$VIRTUAL_ENV"
        __tcsc_prompt_segment venv $tcsc_text_light $tcsc_color_venv
        printf " %s " (basename $VIRTUAL_ENV)
    end
end

function __tcsc_prompt_rust -d "Write out rust version prompt"
    if type -q cargo && cargo locate-project &>/dev/null
        if set -l match (string match -r -- '^cargo (.*?) \(.*?\)' (cargo --version 2> /dev/null))
            __tcsc_prompt_segment rust $tcsc_text_dark $tcsc_color_rust_version
            printf "%s %s " "$tcsc_icon_rust" "$match[2]"
        end
    end
end

function __tcsc_prompt_user -d "Write out the user prompt"
    # If we are under default user, do nothing
    if test "$USER" != "$DEFAULT_USER"
        # Use different colors for normal user and root
        set -g tcsc_user_status_bg
        set -g tcsc_user_status_text $tcsc_text_light
        set -l uid (id -u "$USER")
        if test "$uid" -eq 0
            set tcsc_user_status_bg $tcsc_color_root
        else
            set tcsc_user_status_bg $tcsc_color_user
        end
        __tcsc_prompt_segment user $tcsc_user_status_text $tcsc_user_status_bg
        printf " %s " $USER
    end
end

function __tcsc_prompt_hostname -d "Write out the hostname prompt"
    # Hostname, calculate just once
    if not set -q __tcsc_prompt_hostname
        set -g __tcsc_prompt_hostname (hostname | string split .)[1]
    end

    # Only show remote hosts
    if set -l ppid (ps --format ppid= --pid $fish_pid | string trim)
        switch (ps --format comm= --pid $ppid)
            case sshd mosh-server
                __tcsc_prompt_segment host $tcsc_text_dark $tcsc_color_remote
                printf " at %s " $__tcsc_prompt_hostname
        end
    end
end

function __tcsc_prompt_cwd -d "Write out current working directory"
    # __tcsc_prompt_segment "cwd" $tcsc_text_dark $tcsc_color_cwd
    __tcsc_prompt_segment cwd $tcsc_text_dark $tcsc_color_cwd
    printf " %s " (prompt_pwd)
end

function __tcsc_prompt_git -d "Write out the git prompt"
    # Skip if git is not installed
    type -q git; or return 1

    function __tcsc_git_branch_name -d 'Get branch name'
        if string match --regex 'no branch' "$tcsc_git_status" >/dev/null
            # Not on a branch
            printf "%s %s " $tcsc_icon_detached (__tcsc_git_tag_or_hash)
        else if set branch_name (string match --regex 'commit(s yet)? on (.*)' "$tcsc_git_status[1]")
            # Initial commit
            printf "%s %s " $tcsc_icon_branch $branch_name[3]
        else
            # Otherwise get a branch name normally
            printf "%s %s " $tcsc_icon_branch (string match --regex '## (\S+?)(?:\\.\\.\\.|\s|$)' "$tcsc_git_status")[2]
        end
    end

    function __tcsc_git_tag_or_hash -d 'Get tag or hash'
        if set -l tag (command git describe --tags --exact-match 2> /dev/null)
            printf "%s" $tag
        else if set -l shorthash (command git rev-parse --short HEAD 2> /dev/null)
            # Tag does not match, print a hash
            printf "%s" $shorthash
        else
            printf "(first commit?)"
        end
    end

    function __tcsc_git_set_color -d 'Set color depending on the tree status'
        # If there are more lines than just the branch line, repo is dirty
        if test (count $tcsc_git_status) -gt 1
            if string match --regex 'U\? |\?U |DD |AA ' "$tcsc_git_status" >/dev/null
                set -g tcsc_git_status_bg $tcsc_color_git_conflict
                set -g tcsc_git_status_text $tcsc_text_light
            else
                set -g tcsc_git_status_bg $tcsc_color_git_dirty
                set -g tcsc_git_status_text $tcsc_text_dark
            end
        else
            set -g tcsc_git_status_bg $tcsc_color_git_clean
            set -g tcsc_git_status_text $tcsc_text_dark
        end
    end

    function __tcsc_git_divergence -d 'Get divergence between local and remote'
        set -l branch_info "$tcsc_git_status[1]"
        set -l branch_ahead (string match --regex '\[ahead (\d*)' "$branch_info")
        set -l branch_behind (string match --regex 'behind (\d*)\]' "$branch_info")
        # Check how much we are ahead
        if test (count $branch_ahead) -eq 2; and test "$branch_ahead[2]" -gt 0
            set ahead "$tcsc_icon_ahead $branch_ahead[2]"
        end
        # Check how much we are behind
        if test (count $branch_behind) -eq 2; and test "$branch_behind[2]" -gt 0
            set behind "$tcsc_icon_behind $branch_behind[2]"
        end
        if test -n "$ahead" -a -n "$behind"
            printf "%s%s " "$ahead" "$behind"
        else if test -n "$ahead"
            printf "%s " "$ahead"
        else if test -n "$behind"
            printf "%s " "$behind"
        end
    end

    function __tcsc_git_flags -d 'Get the working tree flags'
        # Initialize counters
        set -l untracked 0
        set -l modified 0
        set -l staged 0
        set -l conflicted 0
        # Get all info about branch
        for i in $tcsc_git_status
            # First two characters show the status
            switch (echo "$i" | string sub --length 2)
                case "U?" "?U" DD AA
                    set conflicted (math $conflicted+1)
                case "?M" "?D"
                    set modified (math $modified+1)
                case "\?\?"
                    set untracked (math $untracked+1)
                case "##"
                    # Branch name; do nothing
                case "*"
                    set staged (math $staged+1)
            end
        end
        # Get number of stashed files
        # set stashed (git stash list | wc -l)

        if test "$untracked" -gt 0
            set git_flags "$tcsc_icon_untracked $untracked "
        end
        if test "$modified" -gt 0
            set git_flags "$git_flags$tcsc_icon_modified $modified "
        end
        if test "$staged" -gt 0
            set git_flags "$git_flags$tcsc_icon_staged $staged "
        end
        if test "$conflicted" -gt 0
            set git_flags "$git_flags$tcsc_icon_conflicted $conflicted "
        end
        if set -q git_flags
            printf "%s" $git_flags
        end
    end

    # Get git repo status
    if set -g tcsc_git_status (command git status --porcelain --branch --ignore-submodules=dirty 2> /dev/null)
        __tcsc_git_set_color
        __tcsc_prompt_segment git $tcsc_git_status_text $tcsc_git_status_bg
        if set -q tcsc_no_counters
            printf " %s%s%s" (__tcsc_git_branch_name)\
            (__tcsc_remove_count (__tcsc_git_divergence))\
            (__tcsc_remove_count (__tcsc_git_flags))
        else
            printf " %s%s%s" (__tcsc_git_branch_name) (__tcsc_git_divergence) (__tcsc_git_flags)
        end
    end
end

function __tcsc_do_math
    math -s 3 $argv \
        | string replace -r '(\.\d*?[1-9]+)0+$' '$1' \
        | string replace -r '\.0*$' ''
end

function __tcsc_humanize_duration -a ms
    if test "$ms" -lt 10000
        echo $ms"ms"
    else if test "$ms" -lt 60000
        echo (__tcsc_do_math "$ms / 1000")"s"
    else if test "$ms" -lt 3600000
        echo (__tcsc_do_math "$ms / 60000")"min"
    else
        # if test "$ms" -lt 86400000
        echo (__tcsc_do_math "$ms / 3600000")"hrs ("$ms"ms!!!)"
    end
end

function __tcsc_prompt_duration
    if test -n "$tcsc_duration_copy"
        __tcsc_prompt_segment duration_hu $tcsc_text_dark $tcsc_color_time_slow
        printf "%s" (__tcsc_humanize_duration $tcsc_duration_copy)
    end
end

function __tcsc_prompt_time
    __tcsc_prompt_segment time $tcsc_text_dark $tcsc_color_time
    printf " %s " (date "+%H:%M")
end

function __tcsc_do_prompt
    # Save the last status
    set -g tcsc_last_status $status
    set -g tcsc_duration_copy $CMD_DURATION

    set -g tcsc_prompt_icon_pad__ ""
    if test "$TERM_PROGRAM" = vscode
        set -g SEPARATORS '' '' '' ''
        # set tcsc_prompt_icon_pad__ " "
    end

    switch $argv[1]
        case -l
            set -g tcsc_separator_thin $SEPARATORS[3]"$tcsc_prompt_icon_pad__"
            set -g tcsc_separator_full $SEPARATORS[1]"$tcsc_prompt_icon_pad__"
            set -g tcsc_prompt_dir l
        case -r
            set -g tcsc_separator_thin $SEPARATORS[4]
            set -g tcsc_separator_full $SEPARATORS[2]
            set -g tcsc_prompt_dir r
    end

    if test "$NOICONFONT" = "1"
        set -g tcsc_prompt_icon_pad__ ''
        set -g tcsc_separator_thin $tcsc_prompt_icon_pad__
        set -g tcsc_separator_full $tcsc_prompt_icon_pad__
    end

    __tcsc_colors_default
    __tcsc_init_icons
    # Disable virtual environment prompt; we have our own override
    set -U VIRTUAL_ENV_DISABLE_PROMPT 1
    for prompt_item in $argv[2..-1]
        if functions -q "$prompt_item"
            eval "$prompt_item"
        end
    end
    __tcsc_prompt_end
end
