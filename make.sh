#!/bin/sh

############################################################################
# Copyright (c) 2020-2024 Silvio Clecio (silvioprog) <silvioprog@gmail.com>
#
# SPDX-License-Identifier: MIT
############################################################################

set -e

output="$(realpath .)/output"
rm -rf "$output"
mkdir -p "$output"

docker_cmd="docker"
if test -x "$(which podman)"; then
  docker_cmd="podman"
fi

echo "Using $docker_cmd ..."

$docker_cmd build --platform linux/arm64 --tls-verify=false -t libsagui-arm64 -f Dockerfile.arm64
$docker_cmd run --platform linux/arm64 -it --rm --privileged -v "$output":/sagui/output libsagui-arm64

$docker_cmd build --platform linux/amd64 --tls-verify=false -t libsagui .
$docker_cmd run --platform linux/amd64 -it --rm --privileged -v "$output":/sagui/output libsagui
