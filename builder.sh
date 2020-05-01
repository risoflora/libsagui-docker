#!/bin/sh

#######################################################################
# Copyright (c) 2020 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

set -e

if [ ! -f /.dockerenv ]; then
  echo "It will be performed by the container automatically. Exiting ...."
  exit 1
fi

dist=/sagui/output

clean() {
  rm -rf ./*
}

version=$(curl -s https://raw.githubusercontent.com/risoflora/libsagui/master/include/sagui.h | sed -n 's/#define SG_VERSION_\(.*\) \([0-9]\)/\2/p' | tr '\n' '.' | sed 's/.$//')
git clone https://github.com/risoflora/libsagui.git libsagui
cd libsagui && mkdir build && cd build/

# linux_amd64
clean
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=./Output ..
make package
cp "libsagui-$version.tar.gz" "$dist/libsagui-$version-linux_amd64.tar.gz"

# windows_amd64
clean
cmake -DMINGW64=ON -DCMAKE_TOOLCHAIN_FILE="../cmake/Toolchain-mingw32-Linux.cmake" ..
make package
cp "libsagui-$version.zip" "$dist/libsagui-$version-windows_amd64.zip"

# windows_386
clean
cmake -DCMAKE_TOOLCHAIN_FILE="../cmake/Toolchain-mingw32-Linux.cmake" ..
make package
cp "libsagui-$version.zip" "$dist/libsagui-$version-windows_386.zip"

# docs
clean
cmake -DSG_BUILD_HTML=ON -DSG_HTTPS_SUPPORT=ON ..
make doc
optipng -o7 docs/html/*.png docs/html/search/*.png
cp -r docs/html $dist/

# checksums
cd $dist/
sha256sum ./*.tar.gz ./*.zip >"libsagui-${version}_checksums.txt"
