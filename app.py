#!/usr/bin/env python
from warnings import filterwarnings
import MySQLdb as db
import os
import hvac
import requests
import time
import threading
import sys

# local variables 
VAULT_ADDR = os.environ['VAULT_ADDR']
VAULT_TOKEN = os.environ['VAULT_TOKEN']

# connect with Vault secret engine
client = hvac.Client(url=VAULT_ADDR, token=VAULT_TOKEN)


#{'renewable': False, 'data': {'data': {'user': 'name', 'pass': 'word'}, '.metadata': {'destroyed': False, 'deletion_time': '', 'created_time': '2018-06-15T01:31:14.398781526Z', 'version': 1}}, 'request_id': '7f09881f-534e-9e92-cf3a-a0739c8f2dc8', 'lease_duration': 0, 'auth': None, 'wrap_info': None, 'lease_id': '', 'warnings': None}
print(client.read('secret/data/prometheus'))
#result = client.read('secret/data/prometheus')['data']['value']
#print "If there was a birth every 7 seconds, there would be: " result "password"
def vault_get(name):
    try:
        client = vault_client['client']
    except KeyError:
        print("Making connection to vault host: {}".format('http://192.168.2.10:8200'))
        vault_client['client'] = hvac.Client(url='http://192.168.2.10:8200', token='c3ee2b92-143a-9a21-1a79-9900c079894b')
        client = vault_client['client']
        print(client.read())

    result = client.read('secret/data/{}'.format(name))
    if result is None:
        raise Exception('Unable to find secret {}'.format(name))
    else:
        try:
            logger.info("Retrieved secret from Vault using key {}".format(name))
            return result['data']['value']
            
        except KeyError:
            logger.error('Unable to find key in response data from Vault')
            raise Exception('Unable to find key in response data from Vault') 



def establishConnection(crt,key):
    client = hvac.Client(url='https://192.168.2.10:8200/v1/sys/internal/ui/mounts/secret/prometheus',
                         verify=False,
                         cert=(crt, key))
    try:
        client.auth_tls()
    except (ConnectionRefusedError, requests.exceptions.ConnectionError, requests.packages.urllib3.exceptions.ProtocolError, hvac.exceptions.VaultDown):
        print("establishConnection() failed.")
    return client

def apiCheck(crt, key):
    client = establishConnection(crt, key)

    result = client.read('secret/prometheus')['data']['password']

    # In the above line, the value returned  



filterwarnings('ignore', category = db.Warning)
try:

    db_name = 'dbname'
    con = db.connect(user='najib', passwd='test123')
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


   
      





