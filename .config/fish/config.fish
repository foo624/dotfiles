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

set -x NVIM_INSTALL $HOME/.local/nvim
if test -d $NVIM_INSTALL/bin
  fish_add_path $NVIM_INSTALL/bin
end

set -x FZF_INSTALL $HOME/.local/fzf
if test -d $FZF_INSTALL/bin
  fish_add_path $FZF_INSTALL/bin
end

set -x NODEJS_INSTALL $HOME/.local/nodejs
if test -d $NODEJS_INSTALL/bin
  fish_add_path $NODEJS_INSTALL/bin
end

set -x YARN_INSTALL $HOME/.yarn
if test -d $YARN_INSTALL/bin
  fish_add_path $YARN_INSTALL/bin
end

# env
if test -x $NVIM_INSTALL/bin/nvim
  set -x SUDO_EDITOR $NVIM_INSTALL/bin/nvim
  set -x EDITOR $NVIM_INSTALL/bin/nvim
else
  set -x SUDO_EDITOR nvim
  set -x EDITOR nvim
end

# alias
#alias la='ls -ah'
#alias ll='ls -lh'
alias lla='ls -alh'
#alias ls='ls --color=auto'

alias cp='cp -aiv'
alias mv='mv -iv'
alias rm='rm -iv'

alias df='df -h'
alias du='du -hc'

if test (which colordiff)
  alias diff='colordiff -u'
else
  alias diff='diff -u --color=always'
end

# abbr
abbr --add . 'cd ../'
abbr --add .. 'cd ../../'
abbr --add ... 'cd ../../../'
abbr --add .2 'cd ../../'
abbr --add .3 'cd ../../../'
abbr --add .4 'cd ../../../../'

abbr --add abe 'for a in (abbr --list); abbr --erase $a; end'
abbr --add abf 'abbr | fzf'

abbr --add bs 'bass source'

abbr --add sai 'sudo apt install'
abbr --add sau 'sudo apt update'
abbr --add saug 'sudo apt upgrade'
abbr --add saa 'sudo apt autoremove'
abbr --add sas 'sudo apt search'
abbr --add sash 'sudo apt show'
abbr --add as 'apt search'
abbr --add ash 'apt show'

abbr --add psf 'ps aux | fzf --layout=reverse --height 100% --header-lines=1'

abbr --add py 'python3'

abbr --add vi nvim
abbr --add vim nvim
abbr --add be 'bundle exec'

abbr --add vncstart 'vncserver -geometry 1440x900 -depth 24'
abbr --add vncend 'vncserver -kill :1'

abbr --add euc2sjis 'iconv -f euc-jp -t sjis'
abbr --add euc2utf 'iconv -f euc-jp -t utf-8'
abbr --add sjis2euc 'iconv -f sjis -t euc-jp'
abbr --add sjis2utf 'iconv -f sjis -t utf-8'
abbr --add utf2euc 'iconv -f utf-8 -t euc-jp'
abbr --add utf2sjis 'iconv -f utf-8 -t sjis'
