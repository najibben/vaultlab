#!/usr/bin/env bash

which jq &>/dev/null || {
echo "jq not present."
apt install -y jq
}
#next 2 commented lines are for vault secret engine reading from Vault

#USER=$(vault kv get secret/prometheus | grep user | awk '{print $2}')
#PASSWD=$(vault kv get secret/prometheus | grep password | awk '{print $2}')


#next 2 commented lines are for using API REST 
#USER=$(curl -s --header "X-Vault-Token:$VAULT_TOKEN" --request GET --data @payload.json --insecure http://192.168.2.10:8200/v1/kv/user |  jq -r '.data' | awk '{print$2}' | perl -ne 'print if /\S/'  | sed -e 's/^"//' -e 's/"$//')
#PASSWD=$(curl -s --header "X-Vault-Token:$VAULT_TOKEN" --request GET --data @payload.json --insecure http://192.168.2.10:8200/v1/kv/password |  jq -r '.data' | awk '{print$2}' | perl -ne 'print if /\S/'  | sed -e 's/^"//' -e 's/"$//') 

# this is using ENV consul
set -e

#sample key to test all works
vault kv put kv/key value=value
vault kv get kv/key

# sample user
vault kv put kv/user value=najib
vault kv get kv/user

# sample pass
vault kv put kv/pass value=test123
vault kv get kv/pass

# we call our legacy app
envconsul -vault-renew-token=false -secret kv/key -secret kv/user -secret kv/pass ./legacyapp.sh


