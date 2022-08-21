# -*- mode: ruby -*-
# vi: set ft=ruby :

K8S_CLUSTER_NAME = "#{ENV['K8S_CLUSTER_NAME']}"
K8S_CLUSTER_CONFIG_FILE = "#{ENV['K8S_CLUSTER_CONFIG_FILE']}"

VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))

Vagrant.configure("2") do |config|
  config.vm.define "kind" do |node|

    node.vm.box = "ubuntu/jammy64"

    node.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2

        ## Safe defaults settings to avoid VBox GUI complaining
        vb.customize [ "modifyvm", :id, "--graphicscontroller", "vmsvga" ]
    end

    node.vm.hostname = "kind"

    node.vm.network "private_network", ip: "192.168.4.200"

    node.vm.provision :shell, :path => "provision/docker.sh"
    # node.vm.provision :shell, :path => "provision/portainer.sh"
    node.vm.provision :shell, :path => "provision/kubectl.sh"
    node.vm.provision :shell, :path => "provision/kubetail.sh"
    node.vm.provision :shell, :path => "provision/helm.sh"
    node.vm.provision "shell" do |s|
      s.path = "provision/kind.sh"
      s.args   = "#{K8S_CLUSTER_NAME} #{K8S_CLUSTER_CONFIG_FILE}"
    end
    # node.vm.provision :shell, :path => "provision/cilium.sh"
    # node.vm.provision :shell, :path => "provision/metallb.sh"

    # all homes are mounted in vagrant box (to adjust to your own home path)
    config.vm.synced_folder "#{Dir.home}", "/home/vagrant/myHome"

    # K8S API server
    # node.vm.network "forwarded_port", guest_ip: "192.168.4.200", guest: 6443, host: 6443
  end
end
