function drmi -d "Fuzzy-find and docker rmi"
  set -l images (docker images | fzf --layout=reverse --height=100% --multi --header-lines=1 | awk '{print $3}')

  if test -n "$images"
    echo docker rmi $images
    docker rmi $images
  end
end
