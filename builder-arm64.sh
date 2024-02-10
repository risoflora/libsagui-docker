#!/bin/sh

#######################################################################
# Copyright (c) 2024 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

set -e

workdir=/sagui/libsagui
dist=/sagui/output
cmake_cmd="cmake -Wno-dev"

clean() {
  cd $workdir
  rm -rf ./build
  mkdir build
  cd build
}

version=$(curl -s https://raw.githubusercontent.com/risoflora/libsagui/main/include/sagui.h | sed -n 's/#define SG_VERSION_\(.*\) \([0-9]\)/\2/p' | tr '\n' '.' | sed 's/.$//')
git clone https://github.com/risoflora/libsagui.git libsagui

# linux_arm64
clean
$cmake_cmd -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=./Output ..
make package
cp "libsagui-$version.tar.gz" "$dist/libsagui-$version-linux_arm64.tar.gz"

# linux_arm64 (TLS)
$cmake_cmd -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=./Output -DSG_HTTPS_SUPPORT=ON ..
make package
cp "libsagui-$version.tar.gz" "$dist/libsagui_tls-$version-linux_arm64.tar.gz"
