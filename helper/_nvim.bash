#!/bin/bash -eu

VERSION="0.7.0"
APP_NAME="nvim"

SOURCE_FILE_NAME="nvim-linux64.tar.gz"
SOURCE_DIR_NAME=`basename ${SOURCE_FILE_NAME} .tar.gz`
SOURCE_URL="https://github.com/neovim/neovim/releases/download/v${VERSION}/${SOURCE_FILE_NAME}"

function download_app() {
  echo "wget ${SOURCE_URL}"
  wget ${SOURCE_URL}
}

function expansion_app() {
  echo "tar xzf ${SOURCE_FILE_NAME}"
  tar xzf ${SOURCE_FILE_NAME}
}

function build_app() {
  echo ""
}

function install_app() {
  target=$1

  echo "mv ${SOURCE_DIR_NAME} ${target}"
  mv ${SOURCE_DIR_NAME} ${target}
}

