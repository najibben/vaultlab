#!/usr/bin/env python
from warnings import filterwarnings
import MySQLdb as db
import os
import hvac
import requests
import time
import threading
import sys
import json

# local variables 
VAULT_ADDR = os.environ['VAULT_ADDR']
VAULT_TOKEN = os.environ['VAULT_TOKEN']

# connect with Vault secret engine
client = hvac.Client(url=VAULT_ADDR, token=VAULT_TOKEN)
    

#load data in Vault secret kv   TO DELETE ( just to have initial provisioning)
data = {
 "user" : "najib",   
 "password" : "test123"
 
}

# write the secrets TO DELETE from script
client.write('secret/data/prometheus', data=data)
result = client.read('secret/data/prometheus')['data']
#print result['data']['password']



def establishConnection(crt,key):
    client = hvac.Client(url=VAULT_ADDR,
                         verify=False,
                         cert=(crt, key))
    try:
        client.auth_tls()
    except (ConnectionRefusedError, requests.exceptions.ConnectionError, requests.packages.urllib3.exceptions.ProtocolError, hvac.exceptions.VaultDown):
        print("establishConnection() failed.")
    return client

def apiCheck(crt, key):
    client = establishConnection(crt, key)

    result = client.read('secret/prometheus')['data']

    # In the above line, the value returned  



filterwarnings('ignore', category = db.Warning)
try:

    db_name = 'dbname'
    mysql_username = result ['data'] ['user']
    mysql_pw = result['data'] ['password']

    con = db.connect(user=mysql_username, passwd=mysql_pw)
    cur = con.cursor()
    
    

    # Create new database
    cur.execute('CREATE DATABASE IF NOT EXISTS ' + db_name + ';')

    # Create PARAMETERS table
    cur.execute('DROP TABLE IF EXISTS ' + db_name + '.PARAMETERS;')
    query = ('CREATE TABLE ' + db_name + '.PARAMETERS ('
      'idPARAMETERS INT(10) NOT NULL AUTO_INCREMENT, '
      'Param_name VARCHAR(30) NULL DEFAULT NULL, '
      'Param_value VARCHAR(255) NULL DEFAULT NULL, '
      'Timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP '
      'ON UPDATE CURRENT_TIMESTAMP, '
      'User_id VARCHAR(20) NULL DEFAULT NULL, '
      'PRIMARY KEY (idPARAMETERS) );' 
    )
    
    
    cur.execute(query)
    

    # Insert entries
    parameters = ['param1', 'param2', 'param3',
        'param4']

    for i, param_name in enumerate(parameters, start=1):
        cur.execute('INSERT INTO ' + db_name + '.PARAMETERS '
            '(idPARAMETERS, Param_name, Param_value, User_id) '
            'VALUES (' + str(i) + ', %s, %s, %s);',
            (param_name, '', 'user2@localhost'))


    
    cur.close()
    con.commit()
except Exception, e:
    print 'Error. Last query: ' + str(cur._last_executed)
    print e
print 'DB installation script finished'   


   
      





