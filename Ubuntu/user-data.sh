#!/bin/bash

#uninstall old version Docker
sudo apt remove docker docker-engine docker.io
sudo apt update
sudo apt purge docker lxc-docker docker-engine docker.io
#install packages to allow apt to use a repository over HTTPS:
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
# Add docker's official GPG KEY
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# setup stable image repo
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
# install Docker CE
sudo apt update 
sudo apt install docker-ce -y

usermod -aG docker ubuntu

# install Docker compose 
sudo curl -L https://github.com/docker/compose/releases/download/v2.14.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
