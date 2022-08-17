#!/bin/bash

set -x

gcc -g -fPIC -c foo.c
gcc -shared foo.o -o libfoo.so
gcc -g -o main_x64 main.c -lfoo -L.
