# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "dockerhost" do |node|

    node.vm.box = "ubuntu/focal64"

    node.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2

        ## Safe defaults settings to avoid VBox GUI complaining
        vb.customize [ "modifyvm", :id, "--graphicscontroller", "vmsvga" ]
    end

    node.vm.hostname = "docker"

    node.vm.network "private_network", ip: "192.168.4.200"

    node.vm.provision :shell, :path => "provision/docker.sh"

    # ssh
    # node.vm.network "forwarded_port", guest_ip: "192.168.4.200", guest: 2222, host: 22
  end
end
