#!/usr/bin/env python
from warnings import filterwarnings
import MySQLdb as db

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


   
      





