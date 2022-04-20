#!/bin/bash

VERSION="3.4.1"
FILENAME="fish-${VERSION}.tar.xz"
FILEBASE=`basename ${FILENAME} .tar.xz`
URL="https://github.com/fish-shell/fish-shell/releases/download/${VERSION}/${FILENAME}"
TARGET_LOCAL_DIR="${HOME}/.local"
TARGET_APP_DIR="${TARGET_LOCAL_DIR}/app"

TMP_DIR=`mktemp -d /tmp/dir-XXXXXX`

if [ ! -d ${TARGET_APP_DIR} ]; then
  mkdir -p ${TARGET_APP_DIR}
fi

if [ ! -d ${TARGET_APP_DIR}/${FILEBASE} ]; then
  pushd ${TMP_DIR}
  wget ${URL}
  tar Jxfv ${FILENAME}

  cd ${FILEBASE}
  mkdir build
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=${TARGET_APP_DIR}/${FILEBASE} ..
  make -j4
  make install

  cd ${TARGET_LOCAL_DIR}
  ln -sf ${TARGET_APP_DIR}/${FILEBASE} fish

  popd
fi

rm -rf ${TMP_DIR}
