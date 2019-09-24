
# Go SDK program to XoR the token bytes with the given OTP

integrate vault with consul storage backend 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

The only two requirements to try the labs are 

* **Vagrant** (https://www.vagrantup.com/) and 
* **Git** (https://git-scm.com/)



### What 


* the Vagrantfile will contain provisioning scripts for the VM : leader01--> 192.168.2.14:8200 leader02-->192.168.2.1:8200  consul---> 192.168.1.11:8500 . [ backend datastores]

* the folder scripts will contain all the necesary packages to install all dependencies needed in your VM

* the go sdk programa **token.go** will do the XoR final operation to decode a root token in the new format.


### How to run
```
vagrant ssh leader01
sudo su -
```

### Installing

```
vagrant up

vagrant ssh leader01

export VAULT_ADDR=https://192.168.2.14:8200
export VAULT_CACERT="/vagrant/etc/vault/mydomain.com.crt"

```

## Running the tests

Travis is used for testing purposes


## Deployment

you can deploy your VM in any cloud environment

## Versioning

 For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Najib Ben** - *Initial work* - [najibben](https://github.com/najibben)

See also the list of [contributors](https://github.com/vaultlab1/contributors) who participated in this project.

