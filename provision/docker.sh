#!/bin/bash

set -eux -o pipefail

apt update

# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
mkdir -p /etc/apt/keyrings

# Use the following command to set up the repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
apt update
apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

# Allow docker on 0.0.0.0:2375
sed -i -e 's@ExecStart=.*@ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H fd:// --containerd=/run/containerd/containerd.sock@' /usr/lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker

# allow docker cli for the vagrant user
usermod -G docker vagrant