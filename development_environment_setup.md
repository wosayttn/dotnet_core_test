# Development Environment Setup

You need these things to develop projects in the Buildroot Project environment. A host system with a minimum of 20 Gbytes of free disk space that is running a supported Linux distribution (i.e. recent releases of Fedora, CentOS, Debian, or Ubuntu), and appropriate packages installed on the system you are using for builds. Nuvoton provide two environment of building image, one is Docker and the other is Linux. Docker is a virtual machine based on host Linux OS, so the setting in the Docker won’t affect the host OS and the Docker can create an environment only for building image. Linux distribution will be updated and may result in building image error, so Docker provided by Nuvoton is a better way than Linux.

# Docker

Docker is an open-source project based on Linux contains. They are similar to virtual machines, but containers are more portable, more resource-friendly, and more dependent on the host operating system. Docker provides a quick and easy way to get up and running with buildroot. Install docker, Example for Ubuntu 20.04:

First, update your existing list of packages:

```bash
$sudo apt-get update
```

Next, install a few prerequisite packages which let apt use packages over HTTPS:

```bash
$sudo apt install apt-transport-https ca-certificates curl
```

software-properties-common
Then add Docker’s official GPG key for the official Docker repository to your system:

```bash
$curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Use the following command to set up the stable repository, add the Docker repository to APT sources:

```bash
$sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
```

Next, update the package database with the Docker packages from the newly added repo:

```bash
$sudo apt-get update
```

Finally, install Docker:

```bash
$sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Then use the Dockerfile to generate the docker image environment. after completion, use the repo utility to download the buildroot project after enter the docker image. [Dockefile source](https://github.com/OpenNuvoton/MA35D1_Docker_Script.git) You can use the docker script we provide.

```bash
$build.sh  Dockerfile  join.sh  README.md
```

To setup docker image and select folder to be share.

```bash
$./build.sh

Please enter absolute path for shared folders(eg:/home/<user name>) :
Enter docker image, you will see “[user name]@[container id]:$”

$./join.sh
ma35d1_test
test@575f27a6d251:~$
```

To Create a shared/buildroot folder and enter

```bash
test@575f27a6d251:~$ mkdir shared/buildroot
test@575f27a6d251:~$ cd shared/buildroot
```

The first time you use repo, you need to set up the GIT environment.

```bash
test@575f27a6d251:~/shared/buildroot$ git config --global user.email "test@test.test.test"
test@575f27a6d251:~/shared/buildroot$ git config --global user.name "test"
```

Using git command to clone MA35D1 buildroot project.

```bash
test@575f27a6d251:~/shared/buildroot$ git clone https://github.com/OpenNuvoton/MA35D1_Buildroot.git
```

You can check Docker documentation:

- <https://docker-curriculum.com/>
- <https://docs.docker.com/get-started/>
- <https://github.com/OpenNuvoton/docker>
