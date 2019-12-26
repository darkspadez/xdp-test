#!/usr/bin/env bash
set -x

function check_os_version() {
  OS_VER=$(lsb_release -a | grep 'Release:' | awk '{print $2}')
  if [[ ${OS_VER} != '18.04' ]]; then
    exit 1
  fi
}

function make_xdp() {
  DEBIAN_FRONTEND=noninteractive apt install -qq -y build-essential make llvm clang < /dev/null > /dev/null
  make
}

function install_xdp() {
  DEV_INT=$(ip -o route get 1.1.1.1 | perl -nle 'if(/dev\s+(\S+)/) {print $1}')
  ip link set dev ${DEV_INT} xdp obj xdp-cf.o
}

function main() {
  #check_os_version
  make_xdp
  install_xdp

  exit 0
}

main "$@"
