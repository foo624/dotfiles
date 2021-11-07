function remove_fish_user_paths -d "Fuzzy-Find and remove fish_user_paths"
  echo $fish_user_paths | tr  ' ' '\n' | nl | fzf | awk '{print $1}' | read -l readline
  [ $readline ] ; and eval set -e fish_user_paths[$readline]
end
