#!/bin/bash

# Update the system
sudo apt-get update -y

# Download and install Amazon CloudWatch Logs agent
sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

# Create a config.json file
sudo bash -c 'cat > /opt/aws/amazon-cloudwatch-agent/bin/config.json' <<-'EOF'
{
	"metrics": {
		"metrics_collected": {
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
				"metrics_collection_interval": 60
			},
			"disk": {
				"measurement": [
					"used_percent"
				],
				"metrics_collection_interval": 86400,
				"resources": [
					"*"
				]
			}
		},
		"append_dimensions": {
			"InstanceId": "${aws:InstanceId}"
		}
	}
}
EOF

# Start the CloudWatch agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

sudo systemctl enable amazon-cloudwatch-agent