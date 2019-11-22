# -*- coding: utf-8 -*-
#
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

# Generated by synthtool. DO NOT EDIT!

from __future__ import absolute_import
import nox
import subprocess
from sys import platform


def build_libcrc32c(session):
    if platform.startswith("win"):
        subprocess.run(["cmd", "-c", "scripts\\windows\\build.bat"])
    elif platform == "linux":
        subprocess.run(["bash", "scripts/local-linux/build_libcrc32c.sh"])
    elif platform == "darwin":
        subprocess.run(["bash", "scripts/osx/build_libcrc32c.sh"])
    else:
        raise Exception("Unsupported")

@nox.session(python="3.7")
def check(session):
    session.install("-e", ".")

    # Run py.test against the unit tests.
    session.run(
        "python",
        "scripts/check_cffi_crc32c.py",
        *session.posargs,
    )
