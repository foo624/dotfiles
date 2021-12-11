#!/bin/bash

set -eu

script_file=${1}
base_dir=${2}
script_dir=${3}

function parse() {
  cmd=${1}

  case "${cmd}" in
    "base_dir" )
      base_dir=${2}
      ;;
    "mkdir" )
      make_directory ${2}
      ;;

    "link" )
      link_file ${2} ${3}
      ;;

    "links" )
      link_files ${2} ${3}
      ;;

    "git" )
      git_clone ${2} ${3}
      ;;

    *)
      ;;
  esac
}

# make_directory
#
#   target: target directory
function make_directory() {
  target=${1}
  target_dir=${base_dir}/${target}

  if [ ! -e ${target_dir} ]; then
    echo "mkdir ${target_dir}"
    mkdir -p ${target_dir}
  else
    echo "[skip] mkdir ${target_dir}"
  fi
}

# link_file
#
#   pathname: target path name
#   filename: target file name
function link_file() {
  pathname=${1}
  filename=${2}

  if [[ ${pathname} == "." ]]; then
    source_dir=${script_dir}
    target_dir=${base_dir}
  else
    source_dir=${script_dir}/${pathname}
    target_dir=${base_dir}/${pathname}
  fi
  source_file=${source_dir}/${filename}
  target_file=${target_dir}/${filename}

  if [ -f ${target_file} ]; then
    if [ ! -L ${target_file} ]; then
      echo "backup ${target_file}"
      mv ${target_file} ${target_file}.dotfile
    fi
  fi

  if [ ! -d ${target_dir} ]; then
    make_directory ${pathname}
  fi

  if [ ! -L ${target_file} ]; then
    echo "link ${source_file} ${target_file}"
    ln -s ${source_file} ${target_file}
  else
    echo "[skip] link ${source_file} ${target_file}"
  fi
}

# link_files
#
#   pathname: target path name
#   extension: target file name extension
function link_files() {
  pathname=${1}
  extension=${2}

  if [[ ${pathname} == "." ]]; then
    source_dir=${script_dir}
    target_dir=${base_dir}
  else
    source_dir=${script_dir}/${pathname}
    target_dir=${base_dir}/${pathname}
  fi
  source_file=${source_dir}/*${extension}

  echo "links ${source_file} ${target_dir}"
  files=`find ${source_dir} -type f -name "*${extension}" -print0 | xargs -0 basename -a`
  for f in ${files}; do
    link_file ${pathname} ${f}
  done

}

# git_clone
#
#   url: target repository
#   pathname: target path name
function git_clone() {
  url=${1}
  pathname=${2}

  if [[ ${pathname} == "." ]]; then
    target_dir=${base_dir}
  else
    target_dir=${base_dir}/${pathname}
  fi

  if [ -d ${target_dir} ]; then
    echo "[skip] git clone ${url} ${target_dir}"
  else
    echo "git clone ${url} ${target_dir}"
    git clone --depth 1 ${url} ${target_dir}
  fi
}

function main() {
  while IFS= read -r line
  do
    if [ -n "$line" ]; then
      parse $line
    fi
  done < ${1}
}

main ${script_file}
