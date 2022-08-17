#!/bin/sh

export DOTNET_ROOT=/usr/share/dotnet-runtime-3.1.26/
export DOTNET_LIB=$DOTNET_ROOT/shared/Microsoft.NETCore.App/3.1.26/
export PATH=$PATH:$DOTNET_ROOT
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
export LD_LIBRARY_PATH=`pwd`:$DOTNET_LIB:$LD_LIBRARY_PATH

time ./main_arm64

cd linux-arm64
time dotnet foo.dll
