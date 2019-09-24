#!/bin/bash

: '
Stress testing for the storagepacker V1

environment : Vagrant VM -->

config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
 

VAULT :

expected results
root@leader01:/vagrant/scripts# vault read -format json identity/group/name/test_group_999 | wc -l
105
root@leader01:/vagrant/scripts# vault read -format json identity/group/name/test_group_1 | wc -l
105
root@leader01:/vagrant/scripts# vault read -format json identity/group/name/supergroup | wc -l
1021

CONSUL :

root@leader01:/vagrant/scripts# consul kv get -recurse -separator="" -keys vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/0
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/1
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/10
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/100
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/101
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/102
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/103
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/104
vault/logical/d21645e5-35b5-f81f-6b3f-ba64479d31f9/packer/group/buckets/105

....  1.. 255 ( buckets) -->

'

install json 
  #sudo apt install -y jq
  
 VAULT_ADDR=https://192.168.2.14:8200 vault policy write example-policy - <<EOF
  path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
  }
EOF

  VAULT_ADDR=https://192.168.2.14:8200 vault auth enable userpass
  accessor=$( VAULT_ADDR=https://192.168.2.14:8200 vault auth list -format json | jq -r '.["userpass/"].accessor')
  VAULT_ADDR=https://192.168.2.14:8200 vault write auth/userpass/users/najib password=vault  policies=example-policy
  #VAULT_ADDR=http://192.168.2.14:8200 vault write auth/userpass/login/najib password=vault  policies=example-policy
  entityID=$(VAULT_ADDR=https://192.168.2.14:8200 vault list -format json identity/entity/id | jq -r '.[0]')
  VAULT_ADDR=https://192.168.2.14:8200 vault write identity/entity-alias canonical_id=$entityID mount_accessor=$accessor name=Najib

  grep VAULT_TOKEN ~/.bash_profile || {
  
  echo export VAULT_TOKEN=`cat rootToken1` | sudo tee -a ~/.bash_profile
  }


# Create entities
# Create sub-groups


for i in {1..80}
do
ENTITY_ID=$(vault write -field=id identity/entity name=test_user_${i} policies=example-policy)
GROUP_ID=$(vault write -field=id identity/group name=test_group_${i} policies=example-policy)
        
       VAR=$(vault list -format json identity/entity/id | jq -r .[${i}])
     
       #next line is to create a full group with 512 elements
       #vault write identity/group name=superman #member_entity_ids=$VAR1
       #vault write identity/group name=megatest #member_entity_ids=$VAR1
    
       #next line is to create sub-groups up to 512 elements
      
        #remove NULL values if the IOPS of your nic needs it
       printf "$VAR," >> VAR_CUMULATIVE.txt
       # count lines to verify we have "n" entities in disk
       printf "$VAR\n" >> VAR_CUMULATIVE1.txt
       #VAR1=$(cat VAR_CUMULATIVE.txt) | awk -F"," '{ for(N=1; N<=NF; N++) if($N=="null") $N=" " } 1' | sed 's/\>/,/g;s/,$//' )
       VAR1=$(cat VAR_CUMULATIVE.txt | awk -F"," '{ for(N=1; N<=NF; N++) if($N=="null") $N=" " } 1' | sed 's/ /,/g' )
      

       vault write identity/group name=test_group_${i} member_entity_ids=$VAR1       
   
       #next line is to create empty sub-groups 
       #vault write identity/group name=test_group_${i}

       #next line is to create supergroup with sub-groups and with 512 entities
       #vault write identity/group name=supergroup member_groups_ids=$GROUP1 member_entity_ids=$VAR1
            
       #next line is to create supergroup with sub-groups 
       #vault write identity/group name=supergroup member_group_ids=$GROUP1   
       #done 
done   

sleep 5
  
for j in {1..1000}
do
GROUP_ID=$(vault write -field=id identity/group name=test_group_${j} policies=example-policy)
       
       VAR1=$(cat VAR_CUMULATIVE.txt | awk -F"," '{ for(N=1; N<=NF; N++) if($N=="null") $N=" " } 1' | sed 's/ /,/g' )
       
       #next line is to create a full group with 512 elements max 
       #vault write identity/group name=megatest #member_entity_ids=$VAR1
         
       #next line is for stress testing
       vault write identity/group name=test_group_${j} member_entity_ids=$VAR1
                
       #next line is to create empty sub-groups 
       #vault write identity/group name=test_group_${i}

       GROUP=$(vault list -format json identity/group/id | jq -r .[${j}])
       printf "$GROUP," >> GROUP_CUMULATIVE.txt
       printf "$GROUP\n" >> GROUP_CUMULATIVE1.txt
       GROUP1=$(cat GROUP_CUMULATIVE.txt | awk -F"," '{ for(N=1; N<=NF; N++) if($N=="null") $N=" " } 1' | sed 's/ /,/g' )

       #next line is to create supergroup with sub-groups and with 512 entities
       #vault write identity/group name=supergroup member_groups_ids=$GROUP1 member_entity_ids=$VAR1
            
        #next line is to create supergroup with sub-groups emtpty and/or with 512 entities max
       vault write identity/group name=supergroup member_group_ids=$GROUP1    
done         
  