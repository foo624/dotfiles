function fssh -d "Fuzzy-find ssh host via ag and ssh into it"
  pt --ignore-case '^host [^*]' --nocolor --nonumbers  --context=0 --nogroup ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh "$result"
end
