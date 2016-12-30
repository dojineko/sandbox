# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "terrywang/archlinux"
  config.vm.network :private_network, ip:"192.168.33.10"

  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 2048
  end
end
