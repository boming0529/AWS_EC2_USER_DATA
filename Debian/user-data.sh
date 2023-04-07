#!/bin/bash

#uninstall old version Docker
sudo apt remove docker docker-engine docker.io containerd runc
# sudo rm -rf /var/lib/docker/
sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key:
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# use the following command to set up the repository:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# setup stable image repo
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

# install Docker CE
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt update 
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y

usermod -aG docker admin

# install Docker compose 
sudo curl -L https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

