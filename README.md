# fish

## PATH

```bash
set -x -U GOPATH $HOME/go
set -x -U GOBIN $GOPATH/bin
set -x -U NVIM_INSTALL $HOME/.local_nvim
set -U fish_user_paths /usr/local/go/bin $GOBIN $NVIM_INSTALL/bin $HOME/.local/bin $fish_user_paths
set -x -U LD_LIBRARY_PATH /usr/local/lib
```

## fzf

- <https://github.com/junegunn/fzf>

```bash
set -x -U FZF_INSTALL $HOME/.fzf
set -U fish_user_paths $FZF_INSTALL/bin $fish_user_paths
```

## deno

- <https://deno.land/>

```bash
set -x -U DENO_INSTALL $HOME/.deno
set -U fish_user_paths $DENO_INSTALL/bin $fish_user_paths
```

## fisher

### install

- <https://github.com/jorgebucaran/fisher>

```bash
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

### plugin

```bash
cp $HOME/.dotfiles/.config/fish/fish_plugins $HOEM/.config/fish/fish_plugins
fisher update
```
