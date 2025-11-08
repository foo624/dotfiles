#!/bin/bash

set -u

for cmd in git curl unzip xz-utils;
do
  if ! (type ${cmd} > /dev/null 2>&1); then
    echo "${cmd} command is not install."
    exit 1
  fi
done

DOT_FILES_DIR="$(cd "$(dirname "${0}")" && pwd)"

bash install_script.bash "script.txt" "${HOME}" "${DOT_FILES_DIR}"

# shell
ln -sf "${HOME}/.local/dircolors-solarized/dircolors.256dark" "${HOME}/.config/dircolors"

# vim
ln -sf "${DOT_FILES_DIR}/.vimrc" "${HOME}/.vim/init.vim"

# nvim
ln -sf "${HOME}/.vim" "${HOME}/.config/nvim"

# fzf
if [ -d "${HOME}/.local/fzf" ]; then
  "${HOME}/.local/fzf/install" --all --xdg --no-zsh
fi

# deno
if [ ! -x "${HOME}/.local/bin/deno" ]; then
  curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL=${HOME}/.local sh
fi
