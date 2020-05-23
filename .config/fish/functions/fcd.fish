function fcd -d "Fuzzy-find and change directory"
  z -l | awk '{print $2}' | fzf +s | read -l result; and cd "$result"
end

