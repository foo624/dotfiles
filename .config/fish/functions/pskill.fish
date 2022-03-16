function pskill -d "Fuzzy-find and ps and kill"
  set -l kill_signal
  if test -n "$argv[1]"
    set kill_signal "-"$argv[1]
  end

  set -l FZF_CMD_OPTS "--layout=reverse --height 100% --multi --header-lines=1"
  set -l results (ps ux | eval fzf $FZF_CMD_OPTS | awk '{print $2}')

  if test -n "$results"
    echo kill $kill_signal $results
    kill $kill_signal $results
  end
end
