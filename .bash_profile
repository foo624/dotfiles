# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# Environment Setting
export LD_LIBRARY_PATH="/usr/local/lib":$LD_LIBRARY_PATH

# ccache
if [ -d "/usr/lib/ccache" ] ; then
  export PATH=/usr/lib/ccache:$PATH
fi

# neovim
if [ -d "$HOME/.local/nvim" ] ; then
  export PATH=$HOME/.local/nvim/bin:$PATH
fi

# fzf
if [ -d "$HOME/.local/fzf" ] ; then
  export PATH=$HOME/.local/fzf/bin:$PATH
fi

# fish
if [ -d "$HOME/.local/fish" ] ; then
  export PATH=$HOME/.local/fish/bin:$PATH
fi

# golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# # rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# pip3
if [ -d "$HOME/.local" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# nodejs
if [ -d "$HOME/.local/node" ] ; then
  export PATH="$HOME/.local/node/bin:$PATH"
fi

# yarn
if [ -d "$HOME/.yarn" ] ; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi
