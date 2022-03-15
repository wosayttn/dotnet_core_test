# INSTALLATION

```base
#!/bin/sh

DOTNET_CORE_FILE=aspnetcore-runtime-3.1.23-linux-arm64.tar.gz
DOTNET_SDK_FILE=dotnet-sdk-3.1.417-linux-arm64.tar.gz
export DOTNET_ROOT=/opt/dotnet

if [ ! -f "$DOTNET_CORE_FILE" ]; then
    wget https://download.visualstudio.microsoft.com/download/pr/677b9c58-362a-463b-8e42-c2812d23d782/d6a7a814daf37f40355e5e4e098e1d13/aspnetcore-runtime-3.1.23-linux-arm64.tar.gz
fi

if [ ! -f "$DOTNET_SDK_FILE" ]; then
    wget https://download.visualstudio.microsoft.com/download/pr/5da6dffe-5c27-4d62-87c7-a3fca48be9bd/967bd7ddc7bbcaef20671175f7b26ee3/dotnet-sdk-3.1.417-linux-arm64.tar.gz
fi

if [ ! -d "$DOTNET_ROOT" ]; then
    mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_CORE_FILE" -C "$DOTNET_ROOT"
    mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_SDK_FILE" -C "$DOTNET_ROOT"
fi

export PATH=$PATH:$DOTNET_ROOT

export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

dotnet new console -o app
cd $DOTNET_ROOT"/app"
dotnet run
```

# TEST
Try to append "Nuvoton MA35D1" words in string and re-run

```bash
root@ma35d1-som:~/app# cat Program.cs
using System;

namespace app
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Nuvoton MA35D1, Hello World!");
        }
    }
}
root@ma35d1-som:~/app# dotnet run
Nuvoton MA35D1, Hello World!
```

# Installation size

```bash
root@ma35d1-som:/opt/dotnet# du -csh  .
365.3M  .
365.3M  total

root@ma35d1-som:~/app# du -csh  .
401.0K  .
401.0K  total
```

# Run the app Elpased Time

```bash
root@ma35d1-som:~/app# time dotnet run
Nuvoton MA35D1, Hello World!

real    0m22.406s
user    0m27.991s
sys     0m2.217s
```
