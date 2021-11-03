function fbrc -d "Fuzzy-find and checkout a branch (including remote branches)"
  git branch --all | grep -v HEAD | fzf | sed "s/.* //" | sed "s#remotes/[^/]*/##" | read -l result; and git checkout "$result"
end
