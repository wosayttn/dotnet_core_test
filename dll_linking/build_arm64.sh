#!/bin/bash

set -x -e

# Remeber to specify the toolchain path and append it to PATH environment variable.
export PATH=~/MA35D1_Buildroot/output/host/bin/:$PATH


aarch64-linux-gcc -v

aarch64-linux-gcc -g -fPIC -c foo.c
aarch64-linux-gcc -shared foo.o -o libfoo.so
aarch64-linux-gcc -g -o main_arm64 main.c -lfoo -L.
