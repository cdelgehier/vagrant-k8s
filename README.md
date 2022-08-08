# Docker Host on MacOS

The purpose of this repository is to have a healthy base for the CKA preparation

## Requirements

* `brew install virtualbox`: The virtualization engine (qemu is also by vagrant)
* `brew install vagrant`:  The tool for building and managing virtual machine environments
* `brew install docker`: The Docker Cli
* `brew install kubectl`: The Kubernetes Cli
* `brew install kind`: The tool for running local Kubernetes clusters using Docker container.

## Start and configure the docker host

Vagrant will start a VM with Docker (a kind of docker-machine)
```shell
# vagrant up
# export DOCKER_HOST='tcp://192.168.4.200:2375'
# docker ps
make docker
```

## Create the kubernetes

On docker host, we create a kubernetes cluster with `kind`
```shell
# kind create cluster --name cdelgehier-k8s --config=kind-cluster.yml
make k8s
```

## Check the kubernetes

```shell
kubectl cluster-info --context kind-cdelgehier-k8s

kubectl cluster-info dump

kubectl get namespaces
```

## Reset

```shell
make clean all
```

## Links

* `tcp://192.168.4.200:2375` The DOCKER_HOST
* `https://192.168.4.200:9443` The Portainer.io