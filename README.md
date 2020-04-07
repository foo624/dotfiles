
# fish

## PATH
set -x -U GOPATH $HOME/go
set -x -U GOBIN $GOPATH/bin
set -U fish_user_paths $fish_user_paths /usr/local/go/bin /home/momo/go/bin

## fzf

https://github.com/junegunn/fzf

## fisherman
https://github.com/fisherman/fisherman/wiki/%E6%97%A5%E6%9C%AC%E8%AA%9E
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman

