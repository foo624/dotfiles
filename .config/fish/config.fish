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
