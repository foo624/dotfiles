#!/bin/bash

if [ -e $HOME/.dircolors-solarized ]; then
  pushd $HOME/.dircolors-solarized
  git pull
  popd
fi

if [ -e $HOME/.bin/z/z.sh ]; then
  pushd $HOME/.bin/z
  git pull
  popd
fi

if [ -e $HOME/.vim/pack/themes/opt/vim-solarized8 ]; then
  pushd $HOME/.vim/pack/themes/opt/vim-solarized8
  git pull
  popd
fi
