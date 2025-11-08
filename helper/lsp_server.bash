#!/bin/bash -eu

if ! (type npm > /dev/null 2>&1); then
  echo "npm command not found."
  exit 1
fi

if ! (type go > /dev/null 2>&1); then
  echo "go command not found."
  exit 2
fi

npm=(
  yarn
  markdownlint-cli
  bash-language-server
  fish-lsp
)

pip=(
  cmake-language-server
  python-lsp-server\[all\]
)

yarn=(
  vscode-langservers-extracted
  yaml-language-server
)

go=(
  github.com/mattn/efm-langserver@latest
)

for app in "${npm[@]}"; do
  if type "${app}" > /dev/null 2>&1; then
    echo "Already installed ${app}"
  else
    echo "Install ${app}"
    npm i -g "${app}"
  fi
done

for app in "${pip[@]}"; do
  if type "${app}" > /dev/null 2>&1; then
    echo "Already installed ${app}"
  else
    echo "Install ${app}"
    pip3 install "${app}"
  fi
done

fish-lsp complete > ~/.config/fish/completions/fish-lsp.fish

for app in "${yarn[@]}"; do
  if type "${app}" > /dev/null 2>&1; then
    echo "Already installed ${app}"
  else
    echo "Install ${app}"
    yarn global add "${app}"
  fi
done

for app in "${go[@]}"; do
  if type "${app}" > /dev/null 2>&1; then
    echo "Already installed ${app}"
  else
    echo "Install ${app}"
    go install "${app}"
  fi
done
