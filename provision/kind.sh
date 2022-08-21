#!/bin/bash

set -eux -o pipefail

KIND_CLI_VERSION="v0.14.0"
K8S_CLUSTER_NAME=$1
K8S_CLUSTER_CONFIG_FILE=$2

curl -L -o /usr/local/bin/kind "https://kind.sigs.k8s.io/dl/${KIND_CLI_VERSION}/kind-linux-amd64"
chmod +x /usr/local/bin/kind

kind create cluster --name ${K8S_CLUSTER_NAME} --config=/vagrant/${K8S_CLUSTER_CONFIG_FILE}

install -d -o vagrant -g vagrant -m 0775 /home/vagrant/.kube
cp ~/.kube/config /home/vagrant/.kube
chown vagrant: /home/vagrant/.kube/config

install -d /home/vagrant/myHome/.kube
cp ~/.kube/config /home/vagrant/myHome/.kube/config