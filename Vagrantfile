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
      l1.vm.network "private_network", ip: "192.168.2.10"
      l1.vm.network "forwarded_port", guest: 8500, host: 8500
      l1.vm.network "forwarded_port", guest: 8200, host: 8200
      l1.vm.provision :shell, :path => "scripts/install_vault.sh"
      l1.vm.provision :shell, :path => "scripts/install_mysql.sh"
      l1.vm.provision :shell, :path => "app.py" 
  end

  



end




