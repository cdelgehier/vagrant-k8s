DOCKER_HOST ?= tcp://192.168.4.200:2375
K8S_CLUSTER_NAME ?= cdelgehier-k8s
K8S_CLUSTER_CONFIG_FILE ?= kind-cluster.yml
export DOCKER_HOST K8S_CLUSTER_NAME K8S_CLUSTER_CONFIG_FILE

.PHONY: all docker k8s clean help requirements-k8s requirements-docker

## all                  : Create the docker engine and k8s cluster
all: docker k8s

requirements-docker:
	@echo "\033[93m== Checking binaries for docker...\033[0m"

	@command -v vagrant > /dev/null 2>&1 || { echo "You need to install vagrant" ; exit 1 ;}
	@command -v VirtualBox > /dev/null 2>&1 || { echo "You need to install VirtualBox" ; exit 1 ;}
	@command -v docker > /dev/null 2>&1 || { echo "You need to install the cli for docker" ; exit 1 ;}

requirements-k8s:
	@echo "\033[93m== Checking binaries for kubernetes...\033[0m"

	@command -v kind > /dev/null 2>&1 || { echo "You need to install kind" ; exit 1 ;}
	@command -v kubectl > /dev/null 2>&1 || { echo "You need to install the cli kubectl" ; exit 1 ;}


## docker               : Create the docker engine
docker: requirements-docker
	@vagrant up

	@echo "\033[93mYou can now use your docker engine with: \033[92mexport DOCKER_HOST='$(DOCKER_HOST)'\033[0m"
	@echo "\033[93mYou can also configure the registry at this url \033[92mhttps://192.168.4.200:9443\033[0m"

## k8s                  : Create a k8s cluster according to K8S_CLUSTER_NAME and K8S_CLUSTER_CONFIG_FILE
k8s: requirements-k8s
	@kind create cluster --name $(K8S_CLUSTER_NAME) --config=$(K8S_CLUSTER_CONFIG_FILE)
	@echo "\033[93m== Listing clusters created in kind\033[0m"
	@kind get clusters

	@echo "\033[93m== Listing contexts in k8s\033[0m"
	@kubectl config get-contexts

	@echo "\033[93m== Listing node in k8s\033[0m"
	@kubectl config use-context kind-$(K8S_CLUSTER_NAME) && kubectl get nodes

k8s-rm:
	@echo "\033[93m== Deleting cluster $(K8S_CLUSTER_NAME)\033[0m"
	@kind delete cluster --name $(K8S_CLUSTER_NAME)
## clean                : Destroy the vagrant box
clean:
	@echo "\033[93m== Cleaning docker host\033[0m"
	@vagrant destroy --force
destroy: clean

## help                 : Display this help
help: Makefile
	@sed -n 's/^##//p' $<