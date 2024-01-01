. /etc/os-release
sudo sh -c "echo 'deb http://deb.debian.org/debian $VERSION_CODENAME-backports main' > /etc/apt/sources.list.d/backports.list"
sudo apt-get update
sudo apt-get -t $VERSION_CODENAME-backports install podman


sudo apt update
sudo apt install python3-pip -y
pip install podman-compose