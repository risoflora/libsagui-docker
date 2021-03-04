#!/bin/sh

############################################################################
# Copyright (c) 2020-2021 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
############################################################################

set -e

workdir=/sagui/libsagui
dist=/sagui/output

clean() {
  cd $workdir
  rm -rf ./build
  mkdir build
  cd build
}

version=$(curl -s https://raw.githubusercontent.com/risoflora/libsagui/master/include/sagui.h | sed -n 's/#define SG_VERSION_\(.*\) \([0-9]\)/\2/p' | tr '\n' '.' | sed 's/.$//')
git clone https://github.com/risoflora/libsagui.git libsagui

# linux_amd64
clean
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=./Output ..
make package
cp "libsagui-$version.tar.gz" "$dist/libsagui-$version-linux_amd64.tar.gz"

# linux_amd64 (TLS)
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=./Output -DSG_HTTPS_SUPPORT=ON ..
make package
cp "libsagui-$version.tar.gz" "$dist/libsagui_tls-$version-linux_amd64.tar.gz"

# windows_amd64
clean
cmake -DMINGW64=ON -DCMAKE_TOOLCHAIN_FILE="../cmake/Toolchain-mingw32-Linux.cmake" ..
make package
cp "libsagui-$version.zip" "$dist/libsagui-$version-windows_amd64.zip"

# windows_amd64 (TLS)
cmake -DMINGW64=ON -DSG_HTTPS_SUPPORT=ON ..
make package
cp "libsagui-$version.zip" "$dist/libsagui_tls-$version-windows_amd64.zip"

# windows_386
clean
cmake -DCMAKE_TOOLCHAIN_FILE="../cmake/Toolchain-mingw32-Linux.cmake" ..
make package
cp "libsagui-$version.zip" "$dist/libsagui-$version-windows_386.zip"

# windows_386 (TLS)
cmake -DSG_HTTPS_SUPPORT=ON ..
make package
cp "libsagui-$version.zip" "$dist/libsagui_tls-$version-windows_386.zip"

# gnutls (i686)
gnutls_version=$(mingw32-pkg-config gnutls --modversion)
zip -9 "$dist/gnutls-${gnutls_version}-mingw_386.zip" /usr/i686-w64-mingw32/sys-root/mingw/bin/*.dll

# gnutls (x86_64)
gnutls_version=$(mingw64-pkg-config gnutls --modversion)
zip -9 "$dist/gnutls-${gnutls_version}-mingw_amd64.zip" /usr/x86_64-w64-mingw32/sys-root/mingw/bin/*.dll

# docs
clean
cmake -DSG_BUILD_HTML=ON -DSG_HTTPS_SUPPORT=ON ..
make doc
optipng -o7 docs/html/*.png docs/html/search/*.png
cp -r docs/html $dist/

# checksums
cd $dist/
sha256sum ./*.tar.gz ./*.zip >"libsagui-${version}_checksums.txt"
