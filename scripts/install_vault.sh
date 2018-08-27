#!/usr/bin/env bash
set -x

IFACE=`route -n | awk '$1 == "192.168.2.0" {print $8}'`
CIDR=`ip addr show ${IFACE} | awk '$2 ~ "192.168.2" {print $2}'`
IP=${CIDR%%/24}

if [ -d /vagrant ]; then
  LOG="/vagrant/logs/vault_${HOSTNAME}.log"
else
  LOG="vault.log"
fi


which /usr/local/bin/vault &>/dev/null || {
    pushd /usr/local/bin
    [ -f vault_0.10.4_linux_amd64.zip ] || {
        sudo wget https://releases.hashicorp.com/vault/0.10.4/vault_0.10.4_linux_amd64.zip
    }
    sudo unzip vault_0.10.4_linux_amd64.zip
    sudo chmod +x vault
    popd
}


if [[ "${HOSTNAME}" =~ "leader" ]] ; then
  #lets kill past instance
  sudo killall vault &>/dev/null

  #lets delete old consul storage
  sudo consul kv delete -recurse vault

  #delete old token if present
  [ -f /vagrant/.vault-token ] && sudo rm /vagrant/.vault-token

  #start vault
  sudo /usr/local/bin/vault server  -dev -dev-listen-address=${IP}:8200  &> ${LOG} &
  echo vault started
  sleep 3 
  
  #copy token to known location
  sudo find / -name '.vault-token' -exec cp {} /vagrant/.vault-token \; -quit


  # enable secret KV version 1
  sudo VAULT_ADDR="http://${IP}:8200" vault secrets enable -version=1 kv


fi