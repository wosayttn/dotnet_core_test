# Requirement

- [MA35D1 Development Environment Setup](./development_environment_setup.md)
- [MA35D1_Buildroot](https://github.com/OpenNuvoton/MA35D1_Buildroot) root system
- A SD card and a MA35D1 board
- [balenaEther](https://www.balena.io/etcher/) flash tool

# Build bootable image for specified MA35D1 board

Please follow [MA35D1 Development Environment Setup](./dotnet_setup.sh) and the [MA35D1_Buildroot](https://github.com/OpenNuvoton/MA35D1_Buildroot) guiding steps to build a bootable image with dotnet-runtim-3.1.26 and flash the image into SD card using [balenaEtcher](https://www.balena.io/etcher/) utility. For example, below commands help you build the bootable image for NuMaker-IoT-MA35D16F70 board is with 128MB main memory size.

```bash
git clone https://github.com/OpenNuvoton/MA35D1_Buildroot
cd MA35D1_Buildroot
make numaker_iot_ma35d16f70_defconfig
```

If your board is with 512MB DDR memory, to specify corresponding device-tree source file names. Please follow these steps as following.

```bash
$ make menuconfig
  Bootloaders  --->
      In-tree Device Tree Source file names (ma35d1-cpu800-wb-128m)  --->
          (X) ma35d1-cpu800-wb-512m

  Kernel -->
      (nuvoton/ma35d1-iot-128m) In-tree Device Tree Source file names
           < Modify to nuvoton/ma35d1-iot-512m >

  <Save & Exit>
```

Finally, to select dotnet-runtime option in menu as following and start the image building. After done, you should get the MA35D1 Linux image in the path.

```bash
$ make menuconfig
  Target packages  --->
      Miscellaneous  --->
          [*] dotnet-runtime

  <Save & Exit>

$ make

  <Now, you have a coffee time.>

$ ls output/images/core-image-buildroot-ma35d1-*m.rootfs.sdcard
```

# Cross-compile dotnet project on Linux x64 host

At first, you can download dotnet-install.sh script on Microsoft dotnet resource page and execute it to install dotnet sdk in Linux x64 host. Then, to create console sample project and do a cross-build for AARCH64 console execution. Finally, to deploy the 'publish' folder to MA35D1 board. You can store the publish folder in an UDISK or sharing over NFS.

```bash
$ wget https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh
$ chmod +x dotnet-install.sh
$ ./dotnet-install.sh
...
...
...
dotnet-install: Installation finished successfully.

$ export PATH=~/.dotnet/:$PATH
$ dotnet --version
6.0.301

$ dotnet new console -o console_ma35d1
The template "Console App" was created successfully.

Processing post-creation actions...
Running 'dotnet restore' on <path/to/console_ma35d1>/console_ma35d1.csproj...
  Determining projects to restore...
  Restored <path/to/console_ma35d1>/console_ma35d1.csproj (in 125 ms).
Restore succeeded.

$ cd console_ma35d1

$ dotnet publish -c Release -r linux-arm64 --self-contained
Microsoft (R) Build Engine version 17.2.0+41abc5629 for .NET
Copyright (C) Microsoft Corporation. All rights reserved.

  Determining projects to restore...
  Restored <path/to/console_ma35d1>/console_ma35d1.csproj (in 7.92 sec).
  console_ma35d1 -> <path/to/console_ma35d1>/bin/Release/net6.0/linux-arm64/console_ma35d1.dll
  console_ma35d1 -> <path/to/console_ma35d1>/bin/Release/net6.0/linux-arm64/publish/
```

# Test dotnet application on MA35D1 Linux

To set related environment variables in shell before running the console_ma35d1 execution in publish folder.

```bash
$ export DOTNET_ROOT=/usr/share/dotnet-runtime-3.1.26/
$ export PATH=$PATH:$DOTNET_ROOT
$ export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
$ cd publish
$ time dotnet console_ma35d1.dll
Hello, World!
real    0m 0.40s
user    0m 0.33s
sys     0m 0.06s
```
