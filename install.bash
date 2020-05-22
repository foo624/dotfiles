#!/bin/bash

function echo_usage () {
  echo "Usage: `basename $0` [ fish | bash ]" 1>&2
}

if [ $# -ne 1 ]; then
  echo_usage
  exit 1
fi

if [[ ! -x `which git` ]]; then
  echo "git command is not found."
  exit 1
fi

DOT_FILES_PATH=$(cd $(dirname $0) && pwd)

# select install dotfiles
if [ $1 = "fish" ]; then
  DOT_FILES=(.gvimrc .lv .vimrc)
else
  DOT_FILES=(.bash_aliases .bash_profile .bashrc .dircolors .gvimrc .lv .vimrc)
else
  echo "$1 is invalid parameter." 1>&2
  echo_usage
  exit 1
fi

# dotfiles
for file in ${DOT_FILES[@]}
do
  if [ -e ${file} ]; then
    if [ ! -L ${file} ]; then
      mv $HOME/$file $HOME/$file.dotfiles
      ln -s $DOT_FILES_PATH/$file $HOME/$file
    fi
  else
    ln -s $DOT_FILES_PATH/$file $HOME/$file
  fi
done

# shell
if [ ! -e $HOME/.dircolors-solarized ]; then
  git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dircolors-solarized
fi
ln -s $HOME/.dircolors-solarized/dircolors.256dark $HOME/.dircolors

# pt
mkdir -p $HOME/.config/pt
ln -s $DOT_FILES_PATH/.config/pt/config.toml $HOME/.config/pt/config.toml

# git
mkdir -p $HOME/.config/git
ln -s $DOT_FILES_PATH/.config/git/ignore $HOME/.config/git/ignore

# fish
mkdir -p $HOME/.config/fish
ln -s $DOT_FILES_PATH/.config/fish/config.fish $HOME/.config/fish/config.fish
ln -s $DOT_FILES_PATH/.config/fish/fishfile $HOME/.config/fish/fishfile

mkdir -p $HOME/.config/fish/functions
ln -s $DOT_FILES_PATH/.config/fish/functions/fish_prompt.fish $HOME/.config/fish/functions/fish_prompt.fish

# vim
mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/after/ftplugin
mkdir -p $HOME/.vim/after/indent
mkdir -p $HOME/.vim/config
mkdir -p $HOME/.vim/dein
mkdir -p $HOME/.vim/pack/themes/opt
ln -s $DOT_FILES_PATH/.vimrc $HOME/.vim/init.vim
ln -s $DOT_FILES_PATH/.vim/config/plugins $HOME/.vim/config/
ln -s $DOT_FILES_PATH/.vim/dein/dein.toml $HOME/.vim/dein/dein.toml
ln -s $DOT_FILES_PATH/.vim/dein/dein_lazy.toml $HOME/.vim/dein/dein_lazy.toml
ln -s $DOT_FILES_PATH/.vim/after/indent/*.vim $HOME/.vim/after/indent/

if [ ! -e $HOME/.vim/pack/themes/opt/vim-solarized8 ]; then
	git clone https://github.com/lifepillar/vim-solarized8.git $HOME/.vim/pack/themes/opt/vim-solarized8
fi

# nvim
mkdir -p $HOME/.cache/dein
ln -s $DOT_FILES_PATH/.vim/dein/dein.toml $HOME/.cache/dein/dein.toml
ln -s $DOT_FILES_PATH/.vim/dein/dein_lazy.toml $HOME/.cache/dein/dein_lazy.toml
ln -s $HOME/.vim $HOME/.config/nvim

