#######################################################################
# Copyright (c) 2020 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

FROM fedora:30

LABEL Maintainer="Silvio Clecio (silvioprog) <silvioprog@gmail.com>"
LABEL Name="libsagui_builder"

RUN dnf upgrade -y

RUN dnf install -y \
    gnutls-devel \
    git \
    curl \
    make \
    clang \
    mingw32-gcc \
    mingw64-gcc \
    mingw32-winpthreads-static \
    mingw64-winpthreads-static \
    cmake \
    doxygen

WORKDIR /sagui

VOLUME /sagui/output

COPY builder.sh .

RUN chmod +x ./builder.sh

ENTRYPOINT ./builder.sh
