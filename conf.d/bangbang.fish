function __tcsc_last_history_item
    echo $history[1]
end
# ignore errors because this is 3.6.0-only
abbr -a !! --position anywhere --function __tcsc_last_history_item 2> /dev/null
