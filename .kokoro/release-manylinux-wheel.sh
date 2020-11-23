#!/bin/bash

set -eo pipefail

cd github/python-crc32c

# Build for ManyLinux
./scripts/manylinux/build.sh

REPO_ROOT=$(pwd)

mkdir ${REPO_ROOT}/../pypi

docker run \
    --rm \
    --interactive \
    --volume ${REPO_ROOT}:/var/code/python-crc32c/ \
    quay.io/pypa/manylinux2014_aarch64 \
    /var/code/python-crc32c/.kokoro/release.sh
