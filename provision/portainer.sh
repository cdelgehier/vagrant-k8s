#!/bin/bash

set -eux -o pipefail

# portainer.io
docker volume create portainer_data
docker run --detach \
  --publish 8000:8000 \
  --publish 9443:9443 \
  --name portainer \
  --restart=always \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume portainer_data:/data \
  portainer/portainer-ce:latest