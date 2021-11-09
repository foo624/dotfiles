function drm -d "Fuzzy-find and docker rm"
  set -l containers (docker ps --all | fzf --layout=reverse --height=100% --multi --header-lines=1 | awk '{print $1}')

  if test -n "$containers"
    echo docker rm $containers
    docker rm $containers
  end
end
