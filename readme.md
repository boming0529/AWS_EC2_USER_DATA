# AWS EC2 Setup Scripts

This repository contains a collection of scripts designed to automate the setup of AWS EC2 instances.

## Scripts Included

- `setup_ebs_mount.sh`: This script mounts an EBS volume to the EC2 instance.
- `setup_node.sh`: This script installs Node.js and Yarn on the EC2 instance.
- `setup_docker.sh`: This script installs Docker on the EC2 instance.
- `setup_podman.sh`: This script installs Podman on the EC2 instance.
- `setup_postgres_client.sh`: This script installs postgresql client on the EC2 instance.
- `setup_cloudwatch_agent_for_amd64.sh`: This script installs and configures the Amazon CloudWatch Agent on the EC2 amd64 instance.
- `setup_cloudwatch_agent_for_arm64.sh`: This script installs and configures the Amazon CloudWatch Agent on the EC2 arm64 instance.

## Usage

To use these scripts, clone the repository and run the desired script with bash