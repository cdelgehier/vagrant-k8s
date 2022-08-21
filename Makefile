DOCKER_HOST ?= tcp://192.168.4.200:2375
K8S_CLUSTER_NAME ?= cdelgehier-k8s
K8S_CLUSTER_CONFIG_FILE ?= kind-cluster.yml
export DOCKER_HOST K8S_CLUSTER_NAME K8S_CLUSTER_CONFIG_FILE

.PHONY: all docker clean help requirements-docker reset destroy

## all                  : Create the docker engine and k8s cluster
all: docker

requirements-docker:
	@echo "\033[93m== Checking binaries for docker...\033[0m"

	@command -v vagrant > /dev/null 2>&1 || { echo "You need to install vagrant" ; exit 1 ;}
	@command -v VirtualBox > /dev/null 2>&1 || { echo "You need to install VirtualBox" ; exit 1 ;}
	@command -v docker > /dev/null 2>&1 || { echo "You need to install the cli for docker" ; exit 1 ;}

## docker               : Create the docker engine
docker: requirements-docker
	@vagrant up

	@echo "\033[93mYou can now use your docker engine with: \033[92mexport DOCKER_HOST='$(DOCKER_HOST)'\033[0m"
# @echo "\033[93mYou can also configure the registry at this url \033[92mhttps://192.168.4.200:9443\033[0m"

## clean                : Destroy the vagrant machine
clean:
	@echo "\033[93m== Cleaning docker host\033[0m"
	@vagrant destroy --force
destroy: clean

## reset                : Destroy and recreate the vagrant machine
reset: clean all

## help                 : Display this help
help: Makefile
	@sed -n 's/^##//p' $<