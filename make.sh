#!/bin/sh

#######################################################################
# Copyright (c) 2020 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

set -e

output="$(realpath .)/output"
rm -rf $output
+mkdir -p $output


docker build -t libsagui .
docker run --rm -v "$output":/sagui/output libsagui
