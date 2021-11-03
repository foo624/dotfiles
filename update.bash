#!/bin/bash

set -u

# dircolors solarized
if [ -e $HOME/.dircolors-solarized ]; then
  pushd $HOME/.dircolors-solarized
  git pull
  popd
fi

# z.sh
if [ -e $HOME/.bin/z/z.sh ]; then
  pushd $HOME/.bin/z
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
if [ -e $HOME/.fzf ]; then
  pushd $HOME/.fzf
  git pull
  $HOME/.fzf/install --all --no-zsh
  popd
fi

# deno
if [ -e $HOME/.deno ]; then
  deno upgrade
fi
