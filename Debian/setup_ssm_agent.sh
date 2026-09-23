#!/bin/bash

# Install AWS Systems Manager Agent (SSM Agent)
#
# notification : EC2 instance need AmazonSSMManagedInstanceCore policy
# IAM Instance Profile, if not agent will register fail.

sudo apt update
sudo apt install -y curl

# fetch IMDSv2 token to read instance metadata
TOKEN=$(curl -sf -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 300")

REGION=$(curl -sf -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/region)

if [ -z "$REGION" ]; then
  echo "無法從 metadata 取得 region，改用預設值 ap-northeast-1"
  REGION="ap-northeast-1"
fi

# amd64 or arm64
ARCH=$(dpkg --print-architecture)

case "$ARCH" in
  amd64|arm64) ;;
  *)
    echo "不支援的架構: $ARCH"
    exit 1
    ;;
esac

# download and install agent
cd /tmp
sudo curl -fsSL -o amazon-ssm-agent.deb \
  "https://s3.${REGION}.amazonaws.com/amazon-ssm-${REGION}/latest/debian_${ARCH}/amazon-ssm-agent.deb"
sudo dpkg -i amazon-ssm-agent.deb
sudo rm -f amazon-ssm-agent.deb

# auto restart
sudo systemctl enable amazon-ssm-agent
sudo systemctl restart amazon-ssm-agent

sudo systemctl status amazon-ssm-agent --no-pager
