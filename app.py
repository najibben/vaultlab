#!/usr/bin/env python


# connect to mysql database

import MySQLdb

db = MySQLdb.connect(host="localhost",    # your host, usually localhost
                     user="najib",         # your username
                     passwd="test123",  # your password
                     db="dbname")        # name of the data base

# you must create a Cursor object. It will let
#  you execute all the queries you need
cur = db.cursor()

# run a simple select

cur.execute("SELECT * from Persons")

# print all the cell of  all the rows
for row in cur.fetchall():
    print row[0]
    print  row[1]
 


#for firstname, lastname in cur.fetchall() :
#        print firstname, lastname


db.close()
