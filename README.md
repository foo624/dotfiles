# dotfiles

## require

- curl
- git
- unzip

## fish

### PATH

```bash
nvim ~/.config/fish/config.fish
```

## fzf

- <https://github.com/junegunn/fzf>

## deno

- <https://deno.land/>

## fisher

- <https://github.com/jorgebucaran/fisher>

```bash
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

### plugin

```bash
fisher update
```

## configuration

### prompt color

```shell
set -U fish_color_prompt_name green
```

### docker completion

```shell
docker completion fish > ~/.config/fish/completions/docker.fish
```
