# XDG Base Directory
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# for fzf key binding
set -U FZF_LEGACY_KEYBINDINGS 0

# for fzf default option
set -x FZF_DEFAULT_OPTS "--height 20% --layout=default"

# dircolor
eval (dircolors -c $XDG_CONFIG_HOME/dircolors)

# fish-colored-man
# Solarized Dark & Green highlight
set -g man_blink -o red
set -g man_bold green
set -g man_standout -b black 93a1a1
set -g man_underline -u 93a1a1

# path
set -x LD_LIBRARY_PATH /usr/local/lib

fish_add_path $HOME/.local/bin

if test -d /usr/local/go/bin
  set -x GOPATH $HOME/go
  set -x GOBIN $GOPATH/bin
  fish_add_path /usr/local/go/bin $GOBIN
end

set -l apps nvim fzf node .yarn
for app in $apps
  fish_add_path $HOME/.local/$app/bin
end

# env
set -l nvim_path $HOME/.local/nvim/bin/nvim
if test -x $nvim_path
  set -x SUDO_EDITOR $nvim_path
  set -x EDITOR $nvim_path
else
  set -x SUDO_EDITOR nvim
  set -x EDITOR nvim
end

# pylint
set -x PYLINTHOME $XDG_CACHE_HOME/pylint

