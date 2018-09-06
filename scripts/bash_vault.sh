#!/usr/bin/env bash

which jq &>/dev/null || {
echo "jq not present."
apt install -y jq

#this is for vault secret engine direct reading
#USER=$(vault kv get secret/prometheus | grep user | awk '{print $2}')
USER=$(curl -s --header "X-Vault-Token:$VAULT_TOKEN" --request GET --data @payload.json --insecure http://192.168.2.10:8200/v1/kv/user |  jq -r '.data' | awk '{print$2}' | perl -ne 'print if /\S/'  | sed -e 's/^"//' -e 's/"$//')
#this is for vault secret engine direct reading
#PASSWD=$(vault kv get secret/prometheus | grep password | awk '{print $2}')
PASSWD=$(curl -s --header "X-Vault-Token:$VAULT_TOKEN" --request GET --data @payload.json --insecure http://192.168.2.10:8200/v1/kv/password |  jq -r '.data' | awk '{print$2}' | perl -ne 'print if /\S/'  | sed -e 's/^"//' -e 's/"$//') 

# create db
echo -e "Setting up our MySQL user and db"
mysql -uroot -p$PASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$PASSWD -e "grant all privileges on $DBNAME.* to '$USER'@'localhost' identified by '$PASSWD'" 


# test user and password
mysql -u "$USER" -p"$PASSWD" -e "SHOW DATABASES"


echo -n '{"value":"najib"}' | vault kv put secret/user -
echo -n '{"value":"test123"}' | vault kv put secret/password -

