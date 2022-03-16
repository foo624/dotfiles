function gbrm -d "Fuzzy-find and git branch and git branch -D"
  set -l FZF_CMD_OPTS "--layout=reverse --height 100% --multi"
  set -l results (git branch --format="%(refname:short)" | eval fzf $FZF_CMD_OPTS)

  if test -n "$results"
    echo git branch -D $results
    git branch -D $results
  end
end

