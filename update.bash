#!/bin/bash

set -u

# dircolors solarized
if [ -e "$HOME/.local/dircolors-solarized" ]; then
  pushd "$HOME/.local/dircolors-solarized" || exit
  git pull
  popd || exit
fi

# z.sh
if [ -e "$HOME/.local/z/z.sh" ]; then
  pushd "$HOME/.local/z" || exit
  git pull
  popd || exit
fi

# vim-solarized8
if [ -e "$HOME/.vim/pack/themes/opt/vim-solarized8" ]; then
  pushd "$HOME/.vim/pack/themes/opt/vim-solarized8" || exit
  git pull
  popd || exit
fi

# fzf
if type fzf > /dev/null 2>&1; then
  pushd "$HOME/.local/fzf" || exit
  git pull
  "$HOME/.local/fzf/install" --all --xdg --no-zsh
  popd || exit
fi

# deno
if type deno > /dev/null 2>&1; then
  deno upgrade
fi
