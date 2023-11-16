#!/bin/bash

# Checks if the /dev/nvme1n1 is already formatted
DEVICE_OUTPUT=$(file -s /dev/nvme1n1)
if [[ $DEVICE_OUTPUT == *"data"* ]]
then
    sudo mkfs -t ext4 /dev/nvme1n1
else
    echo "The device is already formatted."
fi

# Creates a directory as the mount point, does not report an error if it already exists
sudo mkdir -p /opt/workspace

# Changes the owner of the directory to admin
sudo chown admin:admin /opt/workspace

# Mounts the device to /opt/workspace
sudo mount /dev/nvme1n1 /opt/workspace

# automatically mounts when the system restarts
echo '/dev/nvme1n1 /opt/workspace ext4 defaults,nofail 0 0' | sudo tee -a /etc/fstab