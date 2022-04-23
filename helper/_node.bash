#!/bin/bash -eu

VERSION="16.14.2"
APP_NAME="node"

SOURCE_FILE_NAME="node-v${VERSION}-linux-x64.tar.xz"
SOURCE_DIR_NAME=`basename ${SOURCE_FILE_NAME} .tar.xz`
SOURCE_URL="https://nodejs.org/dist/v${VERSION}/${SOURCE_FILE_NAME}"

function download_app() {
  echo "wget ${SOURCE_URL}"
  wget ${SOURCE_URL}
}

function expansion_app() {
  echo "tar Jxf ${SOURCE_FILE_NAME}"
  tar Jxf ${SOURCE_FILE_NAME}
}

function build_app() {
  echo ""
}

function install_app() {
  target=$1

  echo "mv ${SOURCE_DIR_NAME} ${target}"
  mv ${SOURCE_DIR_NAME} ${target}
}

