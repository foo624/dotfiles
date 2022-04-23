#!/bin/bash -eu

VERSION="3.4.1"
APP_NAME="fish"

SOURCE_FILE_NAME="${APP_NAME}-${VERSION}.tar.xz"
SOURCE_DIR_NAME=`basename ${SOURCE_FILE_NAME} .tar.xz`
SOURCE_URL="https://github.com/fish-shell/fish-shell/releases/download/${VERSION}/${SOURCE_FILE_NAME}"

function download_app() {
  wget ${SOURCE_URL}
}

function expansion_app() {
  tar Jxfv ${SOURCE_FILE_NAME}
}

function build_app() {
  target=$1

  cd ${SOURCE_DIR_NAME}
  mkdir build
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=${target} ..
  make -j4
}

function install_app() {
  make install
}

