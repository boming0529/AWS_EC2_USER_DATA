#!/bin/bash

sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gpg \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common


source  /etc/os-release
wget http://downloadcontent.opensuse.org/repositories/home:/alvistack/Debian_$VERSION_ID/Release.key -O alvistack_key
cat alvistack_key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/alvistack.gpg  >/dev/null
echo "deb http://downloadcontent.opensuse.org/repositories/home:/alvistack/Debian_$VERSION_ID/ /" | sudo tee  /etc/apt/sources.list.d/alvistack.list

sudo apt update
sudo apt-get -t $VERSION_CODENAME-backports install podman

sudo apt install python3-pip -y
# install podman and podman compose 
sudo apt install podman python3-podman-compose  -y 
sudo apt update
