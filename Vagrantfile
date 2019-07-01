# -*- mode: ruby -*-
# vi: set ft=ruby :
 
Vagrant.configure(2) do |config|
  config.vm.box = "allthingscloud/go-counter-demo"
  config.vm.provision :shell, :path => "scripts/install_consul.sh"
  
  config.vm.define "consul" do |web|
    web.vm.hostname = "consul"
    web.vm.network "private_network", ip: "192.168.2.11"
  end

 
  config.vm.define "leader01" do |l1|
    l1.vm.hostname = "leader01"
    l1.vm.network "private_network", ip: "192.168.2.14"
    l1.vm.network "forwarded_port", guest: 8500, host: 1236
    l1.vm.network "forwarded_port", guest: 8200, host: 1237
    l1.vm.network "forwarded_port", guest: 8201, host: 1238
    l1.vm.provision :shell, :path => "scripts/install_vault.sh"
   # l1.vm.provision :shell, :path => "scripts/install_mysql.sh"
   # l1.vm.provision :shell, :path => "app.py" 
end

config.vm.define "leader02" do |l2|
  l2.vm.hostname = "leader02"
  l2.vm.network "private_network", ip: "192.168.2.13"
  l2.vm.network "forwarded_port", guest: 8201, host: 1239
  l2.vm.provision :shell, :path => "scripts/install_vault_1.sh"
end




end




