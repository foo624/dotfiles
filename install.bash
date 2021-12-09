#!/bin/bash

set -u

XDG_CONFIG_HOME=${HOME}/.config
XDG_CACHE_HOME=${HOME}/.cache
XDG_DATA_HOME=${HOME}/.local/share
XDG_STATE_HOME=${HOME}/.local/state

function echo_usage () {
  echo "Usage: `basename $0` [ fish | bash ]" 1>&2
}

if [ $# -ne 1 ]; then
  echo_usage
  exit 1
fi

for cmd in git curl unzip;
do
  if [[ ! -x `which ${cmd}` ]]; then
    echo "${cmd} command is not install."
    exit 1
  fi
done

DOT_FILES_PATH=$(cd $(dirname $0) && pwd)

# select install dotfiles
if [ $1 = "fish" ]; then
  DOT_FILES=(.gvimrc .lv .vimrc)
elif [ $1 = "bash" ]; then
  DOT_FILES=(.bash_aliases .bash_profile .bashrc.fzf .bashrc .gvimrc .lv .vimrc)
else
  echo "$1 is invalid parameter." 1>&2
  echo_usage
  exit 1
fi

# dotfiles
for file in ${DOT_FILES[@]}
do
  if [ -e ${HOME}/${file} ]; then
    if [ ! -L ${HOME}/${file} ]; then
      mv ${HOME}/$file ${HOME}/$file.dotfiles
    fi
  fi
  ln -sf ${DOT_FILES_PATH}/$file ${HOME}/$file
done

# shell
if [ ! -e ${HOME}/.dircolors-solarized ]; then
  git clone https://github.com/seebi/dircolors-solarized.git ${HOME}/.dircolors-solarized
fi
ln -sf ${HOME}/.dircolors-solarized/dircolors.256dark ${HOME}/.dircolors

if [ ! -e ${HOME}/.local/z/z.sh ]; then
  mkdir -p ${HOME}/.local/z
  git clone https://github.com/rupa/z.git ${HOME}/.local/z
fi

# byobu
mkdir -p ${XDG_CONFIG_HOME}/byobu
if [ ! -L ${XDG_CONFIG_HOME}/.tmux.conf ]; then
  mv ${XDG_CONFIG_HOME}/byobu/.tmux.conf ${XDG_CONFIG_HOME}/byobu/.tmux.conf.dotfiles
fi
ln -sf ${DOT_FILES_PATH}/.config/byobu/.tmux.conf ${XDG_CONFIG_HOME}/byobu/.tmux.conf

# pt
mkdir -p ${XDG_CONFIG_HOME}/pt
ln -sf ${DOT_FILES_PATH}/.config/pt/config.toml ${XDG_CONFIG_HOME}/pt/config.toml

# git
mkdir -p ${XDG_CONFIG_HOME}/git
ln -sf ${DOT_FILES_PATH}/.config/git/config ${XDG_CONFIG_HOME}/git/config
ln -sf ${DOT_FILES_PATH}/.config/git/ignore ${XDG_CONFIG_HOME}/git/ignore

# tig
mkdir -p ${XDG_DATA_HOME}/tig

# fish
mkdir -p ${XDG_CONFIG_HOME}/fish
ln -sf ${DOT_FILES_PATH}/.config/fish/config.fish ${XDG_CONFIG_HOME}/fish/config.fish
ln -sf ${DOT_FILES_PATH}/.config/fish/fish_plugins ${XDG_CONFIG_HOME}/fish/fish_plugins

mkdir -p ${XDG_CONFIG_HOME}/fish/functions
ln -sf ${DOT_FILES_PATH}/.config/fish/functions/*.fish ${XDG_CONFIG_HOME}/fish/functions/

# vim
mkdir -p ${HOME}/.vim
mkdir -p ${HOME}/.vim/after/ftplugin
mkdir -p ${HOME}/.vim/after/indent
mkdir -p ${HOME}/.vim/config
mkdir -p ${HOME}/.vim/dein
mkdir -p ${HOME}/.vim/ftdetect
mkdir -p ${HOME}/.vim/pack/themes/opt
mkdir -p ${HOME}/.cache/vim_backup
mkdir -p ${HOME}/.cache/vim_swap
mkdir -p ${HOME}/.cache/vim_undo
ln -sf ${DOT_FILES_PATH}/.vimrc ${HOME}/.vim/init.vim
ln -sf ${DOT_FILES_PATH}/.vim/config/plugins ${HOME}/.vim/config/
ln -sf ${DOT_FILES_PATH}/.vim/dein/dein.toml ${HOME}/.vim/dein/dein.toml
ln -sf ${DOT_FILES_PATH}/.vim/dein/dein_lazy.toml ${HOME}/.vim/dein/dein_lazy.toml
ln -sf ${DOT_FILES_PATH}/.vim/after/indent/*.vim ${HOME}/.vim/after/indent/
ln -sf ${DOT_FILES_PATH}/.vim/ftdetect/*.vim ${HOME}/.vim/ftdetect/
ln -sf ${DOT_FILES_PATH}/.cheatsheet.md ${HOME}/.cheatsheet.md

if [ ! -e ${HOME}/.vim/pack/themes/opt/vim-solarized8 ]; then
  git clone https://github.com/lifepillar/vim-solarized8.git ${HOME}/.vim/pack/themes/opt/vim-solarized8
fi

# nvim
mkdir -p ${HOME}/.cache/dein
ln -sf ${DOT_FILES_PATH}/.vim/dein/dein.toml ${HOME}/.cache/dein/dein.toml
ln -sf ${DOT_FILES_PATH}/.vim/dein/dein_lazy.toml ${HOME}/.cache/dein/dein_lazy.toml
ln -sf ${HOME}/.vim ${HOME}/.config/nvim

# fzf
if [ ! -e ${HOME}/.local/fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.local/fzf
  ${HOME}/.local/fzf/install --all --no-zsh
fi

# deno
if [ ! -e ${HOME}/.deno ]; then
  curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL=~/.local sh
fi
