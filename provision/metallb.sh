#!/bin/bash

set -eux -o pipefail

METALLB_VERSION=v0.13.4

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/${METALLB_VERSION}/config/manifests/metallb-native.yaml

kubectl wait pods -n metallb-system --for condition=Ready -l app=metallb --timeout=90s

docker network inspect -f '{{.IPAM.Config}}' kind
kubectl apply -f /vagrant/metallb-configMap.yml