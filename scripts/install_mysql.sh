#!/usr/bin/env bash

USER=najib
PASSWD=test123
DBNAME=dbname

: '
> is for redirect
/dev/null is a black hole where any data sent, will be discarded
2 is the file descriptor for Standard Error
> is for redirect
& is the symbol for file descriptor (without it, the following 1 would be considered a filename)
1 is the file descriptor for Standard Out
Therefore >/dev/null 2>&1 is redirect the output of your program to /dev/null. Include both the  Standard Error and Standard Out.
'

# if mysql is not installed install mysql
: '
script will check if package exits mysql 5.7  and update it if needed
'

# check if mysql is install
which mysql &>/dev/null || {
  echo "MySQL not present."
  debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWD"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWD"
  apt-get update
  apt-get install -y mysql-server
  apt-get install -y python-mysqldb
  sudo apt-get install -y python-pip python-dev build-essential 
  sudo pip install -y hvac
  

}

# create db
echo -e "Setting up our MySQL user and db"
mysql -uroot -p$PASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$PASSWD -e "grant all privileges on $DBNAME.* to '$USER'@'localhost' identified by '$PASSWD'" 

# test user and password
mysql -u "$USER" -p"$PASSWD" -e "SHOW DATABASES"
