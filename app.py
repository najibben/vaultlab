#!/usr/bin/env python


# connect to mysql database

import MySQLdb

db = MySQLdb.connect(host="localhost",    # your host, usually localhost
                     user="najib",         # your username
                     passwd="test123",  # your password
                     db="testdb")        # name of the data base

# you must create a Cursor object. It will let
#  you execute all the queries you need
cur = db.cursor()

# run a simple select
cur.execute("SELECT * FROM YOUR_TABLE_NAME")

# print all the first cell of all the rows
for row in cur.fetchall():
    print row[0]

db.close()

