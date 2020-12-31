#######################################################################
# Copyright (c) 2020 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

FROM fedora:33

LABEL Maintainer="Silvio Clecio (silvioprog) <silvioprog@gmail.com>"
LABEL Name="libsagui"
LABEL Version="1.0.3"

RUN dnf upgrade -y && dnf install -y \
  gnutls-devel \
  git \
  make \
  clang \
  mingw32-gcc \
  mingw64-gcc \
  mingw32-winpthreads-static \
  mingw64-winpthreads-static \
  cmake \
  doxygen \
  optipng

WORKDIR /sagui
COPY builder.sh .
RUN chmod +x ./builder.sh

VOLUME /sagui/output
ENTRYPOINT ./builder.sh
