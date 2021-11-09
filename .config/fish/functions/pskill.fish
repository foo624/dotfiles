function pskill -d "Fuzzy-find and ps and kill"
  set -l kill_signal ""
  if test -n "$argv[1]"
    set kill_signal "-"$argv[1]
  end

  set -l FZF_CMD_OPTS "--layout=reverse --height 100% --header-lines=1"
  ps u | eval fzf $FZF_CMD_OPTS | awk '{print $2}' | read -l result

  if test -n "$result"
    echo kill "$kill_signal" "$result"
    kill -"$kill_signal" "$result"
  end
end
