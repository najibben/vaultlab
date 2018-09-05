#!/usr/bin/env bash


USER=$(vault kv get secret/prometheus | grep user | awk '{print $2}')
PASSWD=$(vault kv get secret/prometheus | grep password | awk '{print $2}')



# create db
echo -e "Setting up our MySQL user and db"
mysql -uroot -p$PASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$PASSWD -e "grant all privileges on $DBNAME.* to '$USER'@'localhost' identified by '$PASSWD'" 


# test user and password
mysql -u "$USER" -p"$PASSWD" -e "SHOW DATABASES"


echo -n '{"value":"najib"}' | vault kv put secret/user -
echo -n '{"value":"test123"}' | vault kv put secret/password -