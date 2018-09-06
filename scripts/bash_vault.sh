#!/usr/bin/env bash


USER=$(vault kv get secret/prometheus | grep user | awk '{print $2}')
PASSWD=$(vault kv get secret/prometheus | grep password | awk '{print $2}')
curl -so envconsul.tgz https://releases.hashicorp.com/envconsul/0.7.3/envconsul_0.7.3_linux_amd64.tgz
tar -xvzf envconsul.tgz
mv envconsul /usr/local/bin/envconsul
chmod +x /usr/local/bin/envconsul

consul agent -dev
consul kv put my-app/max_conns 5

 echo envconsul -prefix my-app env

# create db
echo -e "Setting up our MySQL user and db"
mysql -uroot -p$PASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$PASSWD -e "grant all privileges on $DBNAME.* to '$USER'@'localhost' identified by '$PASSWD'" 


# test user and password
mysql -u "$USER" -p"$PASSWD" -e "SHOW DATABASES"


echo -n '{"value":"najib"}' | vault kv put secret/user -
echo -n '{"value":"test123"}' | vault kv put secret/password -