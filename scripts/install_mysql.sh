
#!/usr/bin/env bash

# check if mysql is install
type mysql >/dev/null 2>&1 && echo "MySQL present." || echo "MySQL not present."

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

#if type mysql >/dev/null 2>&1; then
   
 USER=najib
 PASSWD=test123
 DBNAME=dbname

    # ....


debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWD"
apt-get update
apt-get install -y mysql-server

#else
#    echo "Skipping Database dump."
#fi


# check if user is created

echo -e "Setting up our MySQL user and db"
mysql -uroot -p$PASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$PASSWD -e "grant all privileges on $DBNAME.* to '$USER'@'localhost' identified by '$PASSWD'" > /vagrant/vm_build.log 2>&1 

# if user is not created create user

# test user and password

if [ $PASSWD ]
then
  mysql -u "$USER" -p"$PASSWD" -e "SHOW DATABASES"
else
  mysql -u "$USER" -e "SHOW DATABASES"
fi

#read -s -p "Enter MYSQL root password: " test123

#while ! mysql -u root -p$PASSWD  -e ";" ; do
#read -p "Can't connect, please retry: "   test123
#done
 
#mysql -h instance1-address.com -u username -ppassword -e "show databases"
exit 0


