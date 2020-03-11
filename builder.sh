#######################################################################
# Copyright (c) 2020 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

#!/bin/sh

set -e

dist=/sagui/output

clean() {
    rm -rf *
}

curl -SL https://github.com/risoflora/libsagui/archive/v$SG_VERSION.tar.gz | tar -zx

cd libsagui-$SG_VERSION && mkdir build && cd build/

# linux_amd64
clean
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=./Output ..
make package
cp libsagui-$SG_VERSION.tar.gz $dist/libsagui-$SG_VERSION-linux_amd64.tar.gz

# windows_amd64
clean
cmake -DMINGW64=ON -DCMAKE_TOOLCHAIN_FILE="../cmake/Toolchain-mingw32-Linux.cmake" ..
make package
cp libsagui-$SG_VERSION.zip $dist/libsagui-$SG_VERSION-windows_amd64.zip

# windows_386
clean
cmake -DCMAKE_TOOLCHAIN_FILE="../cmake/Toolchain-mingw32-Linux.cmake" ..
make package
cp libsagui-$SG_VERSION.zip $dist/libsagui-$SG_VERSION-windows_386.zip

# checksums
cd $dist/
sha256sum libsagui-$SG_VERSION-linux_amd64.tar.gz \
    libsagui-$SG_VERSION-windows_amd64.zip \
    libsagui-$SG_VERSION-windows_386.zip >libsagui-${SG_VERSION}_checksums.txt
