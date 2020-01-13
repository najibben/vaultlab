#!/bin/bash
# This is the entry point for configuring the system.
#####################################################

#install basic tools
sudo apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install git
sudo apt-get install -y curl



#get golang 1.12.7
curl -O https://storage.googleapis.com/golang/go1.12.7.linux-amd64.tar.gz

#unzip the archive 
sudo tar -xvf go1.12.7.linux-amd64.tar.gz

#move the go lib to local folder
sudo rm -r /usr/local/go/
sudo mv go /usr/local

#delete the source file
sudo rm  go1.12.7.linux-amd64.tar.gz

#only full path will work
sudo echo "export PATH=$PATH:/usr/local/go/bin" >> /home/vagrant/.bash_profile

sudo echo "export GOPATH=/home/vagrant/workspace:$PATH" >> /home/vagrant/.bash_profile

export GOPATH=/home/vagrant/workspace

sudo mkdir -p "$GOPATH/bin" 


sudo echo "export PATH=$PATH:/usr/local/go/bin" | sudo tee -a ~/.bash_profile
sudo echo "export GOPATH=/home/vagrant/workspace:$PATH" |  sudo tee -a ~/.bash_profile

export GOPATH=/home/vagrant/workspace
sudo mkdir -p "$GOPATH/bin" 
export PATH=$PATH:$GOPATH/bin

sudo su -
 go get -u github.com/mitchellh/gox
 go install github.com/mitchellh/gox

export GOPATH="/home/vagrant/workspace" | sudo tee -a ~/.bash_profile
PATH=$PATH:$GOPATH/bin | sudo tee -a ~/.bash_profile


cd /vagrant/vault
sudo su -
export GOPATH="/home/vagrant/workspace"
PATH=$PATH:$GOPATH/bin
#make


