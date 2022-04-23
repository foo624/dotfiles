#!/bin/bash -eu

if !(type npm > /dev/null 2>&1); then
  echo "npm command not found."
  exit 1
fi

npm=(
  yarn
)

pip=(
  cmake-language-server
  python-lsp-server[all]
)

yarn=(
  bash-language-server
  vscode-langservers-extracted
  yaml-language-server
)

for app in ${npm[@]}; do
  if type ${app} > /dev/null 2>&1; then
    echo "Already installed ${app}"
  else
    echo "Install ${app}"
    npm i -g ${app}
  fi
done

for app in ${pip[@]}; do
  if type ${app} > /dev/null 2>&1; then
    echo "Already installed ${app}"
  else
    echo "Install ${app}"
    pip3 install ${app}
  fi
done

for app in ${yarn[@]}; do
  if type ${app} > /dev/null 2>&1; then
    echo "Already installed ${app}"
  else
    echo "Install ${app}"
    yarn global add ${app}
  fi
done

