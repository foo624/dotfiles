# fish

## PATH

```bash
set -x -U GOPATH $HOME/go
set -x -U GOBIN $GOPATH/bin
set -U fish_user_paths $fish_user_paths /usr/local/go/bin /home/momo/go/bin
set -x -U LD_LIBRARY_PATH /usr/local/lib
```

## fzf

- <https://github.com/junegunn/fzf>

## fisher

- <https://github.com/jorgebucaran/fisher>

```bash
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```
