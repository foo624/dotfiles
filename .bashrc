# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

## 新しく作られたファイルのパーミッションが常に 644 になるようにする。
umask 022

## 環境変数の設定

# Editor setting for 'crontab -e'
export EDITOR=nvim

# RCS setting
export RCSINIT=-zLT

# less のステータス行にファイル名と行数、いま何%かを表示するようにする
export LESS='-X -i -P ?f%f:(stdin). ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

# jless setting
export JLESSCHARSET=japanese

# default pager
export PAGER=lv

# to .bash_profile
## Environment Setting
#LD_LIBRARY_PATH="/usr/local/lib":$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH

# ccache
# to .bash_profile
#export PATH=/usr/lib/ccache:$PATH
export CCACHE_DIR=/mnt/sakura/momo/ccache

## history
function share_history {
	history -a
	history -c
	history -r
}
#PROMPT_COMMAND='share_history'

# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
#shopt -u histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000
export HISTIGNORE=cd*:ls:ll:history*:exit:logout:w

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# なにも入力していないときはコマンド名を補完しない。
shopt -s no_empty_cmd_completion

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# X-ON/X-OFF
stty -ixon -ixoff

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    putty-256color) color_prompt=yes;;
    cygwin) color_prompt=yes;;
    screen-256color-bce) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
#	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#	PS1="\[\e]0;\u@\h: \w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\$(__git_ps1 ' (%s)')\n\$ "
	PS1="\[\e]0;\u@\h: \w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\$(git_branch)\$(hg_branch)\n\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|putty*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	if [ -f ~/.dircolors ]; then
		eval "`dircolors -b ~/.dircolors`"
	else
    	eval "`dircolors -b`"
	fi	
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# 履歴付きのcd
if [ -f ~/tool/cdhist.sh ]; then
	. ~/tool/cdhist.sh
fi

# global complete
funcs()
{
	local cur
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=(`global -c $cur`)
}

complete -F funcs global

git_branch() {
	__git_ps1 ' (git:%s)'
}

hg_branch() {
	if [ -d ./.hg ]; then
		if [ -f ./.hg/branch ]; then
			echo " (hg:`cat ./.hg/branch`)"
		else
			echo " (hg:non-head)"
		fi	
	fi
}

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
