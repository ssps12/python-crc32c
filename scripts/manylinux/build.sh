#!/bin/bash
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e -x
echo "BUILDING ON LINUX"

MANYLINUX_DIR=$(echo $(cd $(dirname ${0}); pwd))
SCRIPTS_DIR=$(dirname ${MANYLINUX_DIR})
REPO_ROOT=$(dirname ${SCRIPTS_DIR})

if [[ "${TRAVIS_CPU_ARCH}" == "arm64" ]] ; then
    arch = aarch64;
    ML_IMAGE="quay.io/pypa/manylinux2014_${arch}"
    continue
elif [[ "${TRAVIS_CPU_ARCH}" == "x86_64" ]] ; then
    arch = x86_64;
    ML_IMAGE="quay.io/pypa/manylinux2010_${arch}"
    continue
fi
docker pull "${ML_IMAGE}"

cd $REPO_ROOT
git submodule update --init --recursive 

docker run \
    --rm \
    --interactive \
    --volume ${REPO_ROOT}:/var/code/python-crc32c/ \
    ${ML_IMAGE} \
    /var/code/python-crc32c/scripts/manylinux/build_on_centos.sh
