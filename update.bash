#!/bin/bash

set -u

# dircolors solarized
if [ -e $HOME/.dircolors-solarized ]; then
  pushd $HOME/.dircolors-solarized
  git pull
  popd
fi

# z.sh
if [ -e $HOME/.local/z/z.sh ]; then
  pushd $HOME/.local/z
  git pull
  popd
fi

# vim-solarized8
if [ -e $HOME/.vim/pack/themes/opt/vim-solarized8 ]; then
  pushd $HOME/.vim/pack/themes/opt/vim-solarized8
  git pull
  popd
fi

# fzf
if type fzf > /dev/null 2>&1; then
  pushd $HOME/.local/fzf
  git pull
  $HOME/.local/fzf/install --all --no-zsh
  popd
fi

# deno
if type deno > /dev/null 2>&1; then
  deno upgrade
fi
