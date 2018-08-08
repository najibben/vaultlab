Vagrant.configure("2") do |config|
  config.vm.box = "cbednarski/ubuntu-1604"
  config.vm.provision :shell, :path => "scripts/install_mysql.sh"
  config.vm.provision :shell, :path => "app.py"  
end
