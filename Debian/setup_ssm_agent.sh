#!/bin/bash

# Install AWS Systems Manager Agent (SSM Agent)
#
# Debian 官方 AMI 預設沒有安裝 SSM Agent，安裝後即可用 Session Manager
# 連線，不需要對外開放 port 22。
#
# 注意：EC2 instance 必須掛上含有 AmazonSSMManagedInstanceCore 權限的
# IAM Instance Profile，否則 agent 會註冊失敗。

set -e

sudo apt update
sudo apt install -y curl

# 取得 IMDSv2 token 來讀取 instance metadata
TOKEN=$(curl -sf -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 300")

REGION=$(curl -sf -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/region)

if [ -z "$REGION" ]; then
  echo "無法從 metadata 取得 region，改用預設值 ap-northeast-1"
  REGION="ap-northeast-1"
fi

# amd64 或 arm64
ARCH=$(dpkg --print-architecture)

case "$ARCH" in
  amd64|arm64) ;;
  *)
    echo "不支援的架構: $ARCH"
    exit 1
    ;;
esac

# 下載並安裝 agent
cd /tmp
sudo curl -fsSL -o amazon-ssm-agent.deb \
  "https://s3.${REGION}.amazonaws.com/amazon-ssm-${REGION}/latest/debian_${ARCH}/amazon-ssm-agent.deb"
sudo dpkg -i amazon-ssm-agent.deb
sudo rm -f amazon-ssm-agent.deb

# 開機自動啟動
sudo systemctl enable amazon-ssm-agent
sudo systemctl restart amazon-ssm-agent

sudo systemctl status amazon-ssm-agent --no-pager
