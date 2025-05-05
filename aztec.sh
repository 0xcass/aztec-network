#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

# Update system and install dependencies
apt-get update
apt-get install -y docker.io docker-compose jq

# Start Docker service
systemctl start docker
systemctl enable docker

# Pull and run Aztec node
docker pull aztecprotocol/aztec:latest
docker run -d \
    --name aztec-node \
    -p 8080:8080 \
    aztecprotocol/aztec:latest

echo "Aztec node is now running!"
echo "You can check the logs using: sudo docker logs -f --tail 100 aztec-node" 