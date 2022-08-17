#!/bin/bash

set -x

aarch64-poky-linux-gcc --sysroot=${SDKTARGETSYSROOT} -g -fPIC -c foo.c
aarch64-poky-linux-gcc --sysroot=${SDKTARGETSYSROOT} -shared foo.o -o libfoo.so
aarch64-poky-linux-gcc --sysroot=${SDKTARGETSYSROOT} -g -o main_arm64 main.c -lfoo -L.
