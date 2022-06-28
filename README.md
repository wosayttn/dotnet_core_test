# Requirement

- UBUNTU Linux OS. Please also refer recommanded [docker building script](https://github.com/OpenNuvoton/MA35D1_Docker_Script/tree/master/docker-yocto)
- MA35D1_Buildroot building
- A SD card
- balenaEther flash tool
(<https://github.com/OpenNuvoton/MA35D1_Docker_Script>)

# Build bootable image for specified MA35D1 board

Please follow the [MA35D1_Buildroot](https://github.com/OpenNuvoton/MA35D1_Buildroot) guiding steps to build a bootable image with dotnet-runtim-3.1.26 and flash the image into SD card using [balenaEtcher](https://www.balena.io/etcher/) utility. For example, below commands help you build the bootable image for NuMaker-IoT-MA35D16F70 board is with 128MB main memory size.

```base
# git clone https://github.com/OpenNuvoton/MA35D1_Buildroot
# cd MA35D1_Buildroot
# make numaker_iot_ma35d16f70_defconfig
# make menuconfig
  <Select dotnet-runtime package in menu as below>

  Target packages  --->
      Miscellaneous  --->
          [*] dotnet-runtime

  <Save & Exit>

# make
  <Now, you have a coffee time.>

# ls output/images/core-image-buildroot-ma35d1-iot-128m.rootfs.sdcard
  <After done, you will get the MA35D1 Linux image.>
```

# Cross-compile dotnet project on Linux x64 host

At first, you can download dotnet-install.sh script and execute it to install dotnet sdk in Linux x64 host. Then, create console project and cross-build AARCH64 console execution. Finally, to deploy the outputted 'publish' folder on MA35D1 Linux board over UDISK.

```bash
# wget https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh
# chmod +x dotnet-install.sh
...
...
...
dotnet-install: Installation finished successfully.

# export PATH=~/.dotnet/:$PATH
# dotnet --version
6.0.301

# dotnet new console -o console_ma35d1
The template "Console App" was created successfully.

Processing post-creation actions...
Running 'dotnet restore' on /home/wayne/console_ma35d1/console_ma35d1.csproj...
  Determining projects to restore...
  Restored /home/wayne/console_ma35d1/console_ma35d1.csproj (in 125 ms).
Restore succeeded.

# cd console_ma35d1

# dotnet publish -c Release -r linux-arm64 --self-contained
Microsoft (R) Build Engine version 17.2.0+41abc5629 for .NET
Copyright (C) Microsoft Corporation. All rights reserved.

  Determining projects to restore...
  Restored <path/to/console_ma35d1>/console_ma35d1.csproj (in 7.92 sec).
  console_ma35d1 -> <path/to/console_ma35d1>/bin/Release/net6.0/linux-arm64/console_ma35d1.dll
  console_ma35d1 -> <path/to/console_ma35d1>/bin/Release/net6.0/linux-arm64/publish/

  <Deploy the 'publish' folder to MA35D1 Linux>

```

# Test dotnet application on MA35D1 Linux

Register related environment variables in shell, then run the console_ma35d1 execution in publish.

```bash
# export DOTNET_ROOT=/usr/share/dotnet-runtime-3.1.26/
# export PATH=$PATH:$DOTNET_ROOT
# export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
# cd publish
# time dotnet console_ma35d1.dll
Hello, World!
real    0m 0.40s
user    0m 0.33s
sys     0m 0.06s
```
