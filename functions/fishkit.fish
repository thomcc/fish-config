function fishkit -d "Create a plugin from a template" -a template
    set -l config_home $XDG_CONFIG_HOME
    set -l cache_home $XDG_CACHE_HOME

    set -l templates "plugin" "prompt" "snippet"
    set -l color (set_color -o)
    set -l nc (set_color normal)

    set -l name
    set -l author (command git config user.name)
    set -l owner
    set -l description
    set -l year (date +%Y)

    function __fishkit_avail_templates -S
        echo "The available templates are:" > /dev/stderr
        printf "       %s\n" $templates > /dev/stderr

        functions -e __fishkit_avail_templates
    end

    function __fishkit_usage -S
        echo "Usage: fishkit [TEMPLATE]" > /dev/stderr
        echo "       fishkit [TEMPLATE] < strings.yaml" > /dev/stderr

        echo > /dev/stderr

        echo "where TEMPLATE can be one of:" > /dev/stderr
        printf "       %s\n" $templates > /dev/stderr

        functions -e __fishkit_usage
    end

    switch "$argv"
        case -h --help
            __fishkit_usage > /dev/stderr
            return
    end

    if test -z "$config_home"
        set config_home ~/.config
    end

    if test -z "$cache_home"
        set cache_home ~/.cache
    end

    set config "$config_home/fisherman/fishkit"

    if test ! -z "$fisher_config"
        set config "$fisher_config/fishkit"
    end

    for t in $templates
        if test ! -e "$config/templates/$t"
            echo "fishkit: I couldn't find any template files." > /dev/stderr
            return 1
        end
    end

    if test -z "$template"
        if not isatty
            echo "fishkit: You need to select a template when reading a file." > /dev/stderr
            __fishkit_avail_templates > /dev/stderr

            return 1
        end

        set -l menu_selected_index
        set -l menu_cursor_glyph (set_color -o white)"•"(set_color normal)
        set -l menu_hover_item_style -o white

        menu $templates

        set template "$templates[$menu_selected_index]"
    end

    set template (printf "%s\n" "$template" | command awk '{ print(tolower($0)) }')

    switch "$template"
        case $templates
        case \*
            echo "fishkit: '$template' is not a valid template." > /dev/stderr
            echo > /dev/stderr
            __fishkit_avail_templates > /dev/stderr

            return 1
    end

    if isatty
        get "$color❯$nc What's your plugin name?" --rule="^[A-Za-z0-9._-]+\$" | read name
        get "$color❯$nc What's your plugin about?" --rule="^[^ *]" | read description
        get "$color❯$nc What's your GitHub username?" --rule="^[^ *]" | read owner

        if test -z "$author"
            get "What's your name? [Optional]" --rule="^[^ *]" | read author
        end
    else
        set -l IFS \t

        command awk -v OFS=\t '

            /^[\t ]#/ {
                next
            }

            {
                if (gsub("^[\t ]*(name):[\t ]*", "")) {
                    name = $0
                }

                if (gsub("^[\t ]*(description):[\t ]*", "")) {
                    description = $0
                }

                if (gsub("^[\t ]*(owner):[\t ]*", "")) {
                    owner = $0
                }


                if (gsub("^[\t ]*(author):[\t ]*", "")) {
                    author = $0
                }
            }

            END {
                print(name, author, owner, description)
            }

        ' | read name author owner description
    end

    if test -z "$owner" -a -z "$author"
        printf "fishkit: I need a GitHub username to create your plugin.\n" > /dev/stderr
        return 1
    end

    if test -z "$owner"
        set owner "$author"
    end

    if test -z "$author"
        set author "$owner"
    end

    if test -z "$name"
        printf "fishkit: I need the name of your plugin.\n" > /dev/stderr
        return 1
    end

    function __fishkit_plugin_validate -a name
        printf "%s\n" $name | command awk '

            BEGIN {
                $0 = tolower($0)
            }

            {
                if (length($0) > 20) {
                    exit
                }
            }

            /^\.?[a-z0-9]+([_-][a-z0-9]+)*$/ {
                s = $0
            }

            END {
                print($0)
                exit s == ""
            }

        '

        functions -e __fishkit_plugin_validate
    end

    if not set name (__fishkit_plugin_validate "$name")
        printf "fishkit: '%s' is not a valid plugin name.\n" "$name" > /dev/stderr
        return 1
    end

    set -l index "$cache_home/fisherman/.index"

    if test ! -z "$fisher_cache"
        set index "$fisher_cache/.index"
    end

    command awk -F '\t' -v key="$name" '

        BEGIN {
            key = tolower(key)
        }

        $1 == key {
            print("fishkit: Caution: \'" key "\' already exists in:")
            print("         https://github.com/fisherman/" key "")
            exit
        }

    ' "$index" > /dev/stderr ^ /dev/null

    if test -z "$description"
        set description "Add $name description here."
    end

    if not command cp -fR "$config/templates/$template" "$name"
        printf "fishkit: There was an error copying your template.\n" "$name" > /dev/stderr
        return 1
    end

    pushd "$name"

    command rm -rf .git

    for file in **
        if test -f "$file"
            command sed -i.tmp "s|{{YEAR}}|$year|g" "$file"
            command sed -i.tmp "s|{{PLUGIN-NAME}}|$name|g" "$file"
            command sed -i.tmp "s|{{PLUGIN-DESCRIPTION}}|$description|g" "$file"
            command sed -i.tmp "s|{{AUTHOR-NAME}}|$author|g" "$file"
            command sed -i.tmp "s|{{OWNER-NAME}}|$owner|g" "$file"

            set -l dir (dirname "$file")

            switch (basename $file)
                case "{{PLUGIN-NAME}}.md"
                    command mv -f $file "$dir/$name".md

                case "{{PLUGIN-NAME}}.fish"
                    command mv -f $file "$dir/$name".fish
            end

            command rm -f "$file.tmp"
        end
    end

    for file in .* **
        if test -f "$file"
            printf "  %s\n" $file
        end
    end
end
