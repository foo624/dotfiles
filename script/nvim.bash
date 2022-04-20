#!/bin/bash

VERSION="v0.7.0"
FILENAME="nvim-linux64.tar.gz"
FILEBASE=`basename ${FILENAME} .tar.gz`
URL="https://github.com/neovim/neovim/releases/download/${VERSION}/${FILENAME}"
TARGET_LOCAL_DIR="${HOME}/.local"
TARGET_APP_DIR="${TARGET_LOCAL_DIR}/app"

TMP_DIR=`mktemp -d /tmp/dir-XXXXXX`

if [ ! -d ${TARGET_APP_DIR} ]; then
  mkdir -p ${TARGET_APP_DIR}
fi

pushd ${TMP_DIR}
wget ${URL}
tar xvzf ${FILENAME}

if [ ! -d ${TARGET_APP_DIR}/${FILEBASE} ]; then
  mv ${FILEBASE} ${TARGET_APP_DIR}/${FILEBASE}-${VERSION}
  pushd ${TARGET_LOCAL_DIR}
  ln -sf ${TARGET_APP_DIR}/${FILEBASE}-${VERSION} nvim
  popd
fi
popd

rm -rf ${TMP_DIR}
