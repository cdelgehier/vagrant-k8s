#!/bin/bash

set -eux -o pipefail

KUBECTL_CLI_VERSION=$(curl -s curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
curl -L -o /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_CLI_VERSION}/bin/linux/amd64/kubectl"
chmod +x /usr/local/bin/kubectl
