#######################################################################
# Copyright (c) 2020 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

#!/bin/sh

set -e

output=$(realpath .)/output

docker build -t libsagui_builder .

docker run --rm -v $output:/sagui/output libsagui_builder
