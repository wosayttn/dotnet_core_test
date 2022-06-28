#!/bin/sh

DOTNET_CORE_FILE=aspnetcore-runtime-3.1.23-linux-arm64.tar.gz
#DOTNET_SDK_FILE=dotnet-sdk-3.1.417-linux-arm64.tar.gz
export DOTNET_ROOT=/opt/dotnet

if [ ! -d "$DOTNET_ROOT" ]; then
    mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_CORE_FILE" -C "$DOTNET_ROOT"
#    mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_SDK_FILE" -C "$DOTNET_ROOT"
fi

export PATH=$PATH:$DOTNET_ROOT
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

#cd ~
#dotnet new console -o app
#cd app
#dotnet run

