# dircolor
eval (dircolors -c ~/.dircolors)

# env
set -x SUDO_EDITOR nvim

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

