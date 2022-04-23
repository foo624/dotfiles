#!/bin/bash -eu

if [ $# -ne 1 ]; then
  echo "Usage: $0 target_script";
  exit 1
fi

target_script=$1

if [ ! -f ${target_script} ]; then
  echo "No such file: ${target_script}";
  exit 2
fi

source ${target_script}

TARGET_DIR=${APP_NAME}
TARGET_DIR_VERSION=${TARGET_DIR}-${VERSION}
TARGET_LOCAL_PATH="${HOME}/.local"
TARGET_DIR_APP="app"

# create directory.
if [ ! -d ${TARGET_LOCAL_PATH}/${TARGET_DIR_APP} ]; then
  mkdir -p ${TARGET_LOCAL_PATH}/${TARGET_DIR_APP}
fi

if [ ! -d ${TARGET_LOCAL_PATH}/${TARGET_DIR_APP}/${TARGET_DIR_VERSION} ]; then
  TMP_DIR=`mktemp -d /tmp/dir-XXXXXX`

  pushd ${TMP_DIR} > /dev/null

  download_app

  expansion_app

  build_app "${TARGET_LOCAL_PATH}/${TARGET_DIR_APP}/${TARGET_DIR_VERSION}"

  install_app "${TARGET_LOCAL_PATH}/${TARGET_DIR_APP}/${TARGET_DIR_VERSION}"

  cd ${TARGET_LOCAL_PATH}
  echo "ln -nfs ${TARGET_DIR_APP}/${TARGET_DIR_VERSION} ${TARGET_DIR}"
  ln -nfs ${TARGET_DIR_APP}/${TARGET_DIR_VERSION} ${TARGET_DIR}

  popd > /dev/null

  rm -rf ${TMP_DIR}
else
  echo "Already installed ${TARGET_LOCAL_PATH}/${TARGET_DIR_APP}/${TARGET_DIR_VERSION}"
fi

