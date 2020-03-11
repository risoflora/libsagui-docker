#######################################################################
# Copyright (c) 2020 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

#!/bin/sh

set -e

version="${SG_VERSION:-2.5.2}"

output=$(realpath .)/output

docker build -t libsagui_builder .

docker run \
    -v $output:/sagui/output \
    -e SG_VERSION=$version \
    libsagui_builder
