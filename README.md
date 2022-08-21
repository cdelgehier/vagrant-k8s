# Docker Host on MacOS

The purpose of this repository is to have a healthy base for the CKA preparation

## Requirements

* `brew install virtualbox`: The virtualization engine (qemu is also by vagrant)
* `brew install vagrant`:  The tool for building and managing virtual machine environments
* `brew install docker`: The Docker Cli
* `brew install kubectl`: The Kubernetes Cli (optional)

## Start and configure the docker host

Vagrant will start a VM with Docker (a kind of docker-machine)
```shell
# vagrant up
# export DOCKER_HOST='tcp://192.168.4.200:2375'
# docker ps
make docker
```

## Reset (~ 4 minutes)

```shell
make reset
```

## Links

* `tcp://192.168.4.200:2375` The DOCKER_HOST
* `https://192.168.4.200:9443` The Portainer.io (disabled)