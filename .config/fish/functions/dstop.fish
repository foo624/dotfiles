function dstop -d "Fuzzy-find and docker stop"
  set -l containers (docker ps | fzf --layout=reverse --height=100% --multi --header-lines=1 | awk '{print $1}')

  if test -n "$containers"
    echo docker stop $containers
    docker stop $containers
  end
end
