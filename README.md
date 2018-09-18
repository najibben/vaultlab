
# vaultlab1 

this first lab to integrate vault in consul backend and storage the DB credentials securely.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

The only two requirements to try the labs are 

* **Vagrant** (https://www.vagrantup.com/) and 
* **Git** (https://git-scm.com/)



### What 

This is sample legacyapp that requires user/pass to connect to a db. 

* the Vagrantfile will contain provisioning scripts for the VM : leader01--> 192.168.1.10:8200 consul---> 192.168.1.11:8500 . [ backend datastores]

* the folder scripts will contain all the necesary packages to install all dependencies needed in your VM

* the script **appy** will update the database and load parametrizable data into it. Database will be created , and the table PARAMETERS uploaded.

* ENVCONSUL is used to set the env variables for Vault.

* We setup a Vault node, and using envconsul to run our legacyapp.sh we can get the values from vault.

* added a Vault cluster in HA , added new consul agent

### How to run
```
vagrant ssh leader01
sudo su -
cd /vagrant/scripts; ./bash_vault.sh
```

```
Give examples
```

### Installing

```
vagrant up

```

## Running the tests

Travis is used for testing purposes

### Break down into end to end tests

on progress

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

you can deploy your VM in any cloud environment


## Contributing

Please read [CONTRIBUTING.md](git@github.com:najibben/vaultlab1.git) you can send a PR for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

 For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Najib Ben** - *Initial work* - [najibben](https://github.com/najibben)

See also the list of [contributors](https://github.com/vaultlab1/contributors) who participated in this project.

## License

This project is for trainning only , no LICENCED file ( at the moment)  for details

## Acknowledgments

* Thanks to Hashicorp
