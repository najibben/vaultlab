#!/usr/bin/env bash

export USER=$kv_user_value
export PASSWD=$kv_pass_value

# create db
echo -e "Setting up our MySQL user and db"
mysql -uroot -p$PASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$PASSWD -e "grant all privileges on $DBNAME.* to '$USER'@'localhost' identified by '$PASSWD'" 


# test user and password
mysql -u "$USER" -p"$PASSWD" -e "SHOW DATABASES"

