#!/bin/bash

set -u

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
  DOT_FILES=(.gvimrc .lv .vimrc .gitconfig)
elif [ $1 = "bash" ]; then
  DOT_FILES=(.bash_aliases .bash_profile .bashrc.fzf .bashrc .gvimrc .lv .vimrc .gitconfig)
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
      mv $HOME/$file $HOME/$file.dotfiles
    fi
  fi
  ln -sf $DOT_FILES_PATH/$file $HOME/$file
done

# shell
if [ ! -e $HOME/.dircolors-solarized ]; then
  git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dircolors-solarized
fi
ln -sf $HOME/.dircolors-solarized/dircolors.256dark $HOME/.dircolors

if [ ! -e $HOME/.bin/z/z.sh ]; then
  mkdir -p $HOME/.bin
  git clone https://github.com/rupa/z.git $HOME/.bin/z
fi

# byobu
mkdir -p $HOME/.byobu
if [ ! -L $HOME/.byobu/.tmux.conf ]; then
  mv $HOME/.byobu/.tmux.conf $HOME/.byobu/.tmux.conf.dotfiles
fi
ln -sf $DOT_FILES_PATH/.byobu/.tmux.conf $HOME/.byobu/.tmux.conf

# pt
mkdir -p $HOME/.config/pt
ln -sf $DOT_FILES_PATH/.config/pt/config.toml $HOME/.config/pt/config.toml

# git
mkdir -p $HOME/.config/git
ln -sf $DOT_FILES_PATH/.config/git/ignore $HOME/.config/git/ignore

# fish
mkdir -p $HOME/.config/fish
ln -sf $DOT_FILES_PATH/.config/fish/config.fish $HOME/.config/fish/config.fish
ln -sf $DOT_FILES_PATH/.config/fish/fish_plugins $HOME/.config/fish/fish_plugins

mkdir -p $HOME/.config/fish/functions
ln -sf $DOT_FILES_PATH/.config/fish/functions/*.fish $HOME/.config/fish/functions/

# vim
mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/after/ftplugin
mkdir -p $HOME/.vim/after/indent
mkdir -p $HOME/.vim/config
mkdir -p $HOME/.vim/dein
mkdir -p $HOME/.vim/ftdetect
mkdir -p $HOME/.vim/pack/themes/opt
mkdir -p $HOME/.cache/vim_backup
mkdir -p $HOME/.cache/vim_swap
mkdir -p $HOME/.cache/vim_undo
ln -sf $DOT_FILES_PATH/.vimrc $HOME/.vim/init.vim
ln -sf $DOT_FILES_PATH/.vim/config/plugins $HOME/.vim/config/
ln -sf $DOT_FILES_PATH/.vim/dein/dein.toml $HOME/.vim/dein/dein.toml
ln -sf $DOT_FILES_PATH/.vim/dein/dein_lazy.toml $HOME/.vim/dein/dein_lazy.toml
ln -sf $DOT_FILES_PATH/.vim/after/indent/*.vim $HOME/.vim/after/indent/
ln -sf $DOT_FILES_PATH/.vim/ftdetect/*.vim $HOME/.vim/ftdetect/
ln -sf $DOT_FILES_PATH/.cheatsheet.md $HOME/.cheatsheet.md

if [ ! -e $HOME/.vim/pack/themes/opt/vim-solarized8 ]; then
  git clone https://github.com/lifepillar/vim-solarized8.git $HOME/.vim/pack/themes/opt/vim-solarized8
fi

# nvim
mkdir -p $HOME/.cache/dein
ln -sf $DOT_FILES_PATH/.vim/dein/dein.toml $HOME/.cache/dein/dein.toml
ln -sf $DOT_FILES_PATH/.vim/dein/dein_lazy.toml $HOME/.cache/dein/dein_lazy.toml
ln -sf $HOME/.vim $HOME/.config/nvim

# fzf
if [ ! -e $HOME/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --all --no-zsh
fi

# deno
if [ ! -e $HOME/.deno ]; then
  curl -fsSL https://deno.land/x/install/install.sh | sh
fi
