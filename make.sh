#!/bin/sh

#######################################################################
# Copyright (c) 2020 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
#######################################################################

set -e

output="$(realpath .)/output"
rm -rf "$output"
mkdir -p "$output"

docker_cmd="docker"
if test -x "$(which podman)"; then
  docker_cmd="podman"
fi

echo "Using $docker_cmd ..."

$docker_cmd build -t libsagui .
$docker_cmd run --rm --privileged -v "$output":/sagui/output libsagui
