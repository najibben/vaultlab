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
#for row in cur.fetchall():
#    print row[0]
#    print row[1]
#    print row[2]
#    print row[3]

rows = cur.fetchall()
for i, row in enumerate(rows):
    print "Row", i, "value = ", row
#for firstname, lastname in cur.fetchall() :
#        print firstname, lastname


db.close()


