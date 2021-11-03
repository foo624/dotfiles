# dircolor
eval (dircolors -c ~/.dircolors)

# env
if test -x ~/.local_nvim/bin/nvim
  set -x SUDO_EDITOR ~/.local_nvim/bin/nvim
  set -x EDITOR ~/.local_nvim/bin/nvim
else
  set -x SUDO_EDITOR nvim
  set -x EDITOR nvim
end

set -x LD_LIBRARY_PATH /usr/local/lib

fish_add_path $HOME/.local/bin

set -x GOPATH $HOME/go
set -x GOBIN $GOPATH/bin
fish_add_path /usr/local/go/bin $GOBIN

set -x NVIM_INSTALL $HOME/.local_nvim
fish_add_path $NVIM_INSTALL/bin

set -x FZF_INSTALL $HOME/.fzf
fish_add_path $FZF_INSTALL/bin

set -x DENO_INSTALL $HOME/.deno
fish_add_path $DENO_INSTALL/bin

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

if test -x (which colordiff)
  alias diff='colordiff -u'
else
  alias diff='diff -u --color=always'
end

alias euc2sjis='iconv -f euc-jp -t sjis'
alias euc2utf='iconv -f euc-jp -t utf-8'
alias sjis2euc='iconv -f sjis -t euc-jp'
alias sjis2utf='iconv -f sjis -t utf-8'
alias utf2euc='iconv -f utf-8 -t euc-jp'
alias utf2sjis='iconv -f utf-8 -t sjis'

alias vi=vim

alias vncstart='vncserver -geometry 1440x900 -depth 24'
alias vncend='vncserver -kill :1'

alias be='bundle exec'

# for fisherman color
set fish_color_match red

# for fzf key binding
set -U FZF_LEGACY_KEYBINDINGS 0

# for fzf default option
set -U FZF_DEFAULT_OPTS "--height 40% --reverse"
