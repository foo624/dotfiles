#!/bin/bash

DOT_FILES_PATH=$(cd $(dirname $0) && pwd)

DOT_FILES=(.bash_aliases .bash_profile .bashrc .dircolors .gvimrc .lv .vimrc)

for file in ${DOT_FILES[@]}
do
	ln -s $DOT_FILES_PATH/$file $HOME/$file
done

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

ln -s $DOT_FILES_PATH/.vim/after/ftplugin/ruby.vim $HOME/.vim/after/ftplugin/ruby.vim
ln -s $DOT_FILES_PATH/.vim/after/indent/ant.vim $HOME/.vim/after/indent/ant.vim
ln -s $DOT_FILES_PATH/.vim/after/indent/css.vim $HOME/.vim/after/indent/css.vim
ln -s $DOT_FILES_PATH/.vim/after/indent/html.vim $HOME/.vim/after/indent/html.vim
ln -s $DOT_FILES_PATH/.vim/after/indent/php.vim $HOME/.vim/after/indent/php.vim
ln -s $DOT_FILES_PATH/.vim/after/indent/ruby.vim $HOME/.vim/after/indent/ruby.vim
ln -s $DOT_FILES_PATH/.vim/after/indent/smarty.vim $HOME/.vim/after/indent/smarty.vim
ln -s $DOT_FILES_PATH/.vim/after/indent/sql.vim $HOME/.vim/after/indent/sql.vim
ln -s $DOT_FILES_PATH/.vim/after/indent/yaml.vim $HOME/.vim/after/indent/yaml.vim

if [ ! -e $HOME/.vim/pack/themes/opt/vim-solarized8 ]; then
	git clone https://github.com/lifepillar/vim-solarized8.git $HOME/.vim/pack/themes/opt/vim-solarized8
fi

# nvim
mkdir -p $HOME/.cache/dein
ln -s $DOT_FILES_PATH/.vim/dein/dein.toml $HOME/.cache/dein/dein.toml
ln -s $DOT_FILES_PATH/.vim/dein/dein_lazy.toml $HOME/.cache/dein/dein_lazy.toml
ln -s $DOT_FILES_PATH/.vim $HOME/.config/nvim

