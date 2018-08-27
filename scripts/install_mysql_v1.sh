!/usr/bin/env python
from __future__ import print_function
from warnings import filterwarnings
import MySQLdb as db

# connect to mysql database
db = MySQLdb.connect(host="localhost",    # your host, usually localhost
                     user="najib",         # your username
                     passwd="test123",  # your password
                     db="dbname")        # name of the data base

# you must create a Cursor object. It will let
#  you execute all the queries you need
cursor = db.cursor() 


filterwarnings('ignore', category = db.Warning)
try:
    
    # Create new database
    cursor.execute('CREATE DATABASE IF NOT EXISTS ' + db + ';')

    # Create PARAMETERS table
    cursor.execute('DROP TABLE IF EXISTS ' + db + '.PARAMETERS;')
    query = ('CREATE TABLE ' + db + '.PARAMETERS ('
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

    
except Exception, e:
    print 'Error. Last query: ' + str(cur._last_executed)
    print e
print 'DB installation script finished'

sql = '''CREATE TABLE IF NOT EXISTS foo (
       bar VARCHAR(50) DEFAULT NULL
       ) ENGINE=MyISAM DEFAULT CHARSET=latin1
       '''
cursor.execute(sql)

sql = '''CREATE TABLE IF NOT EXISTS employees (
       first_name VARCHAR(50) DEFAULT NULL
       last_name VARCHAR(50) DEFAULT NULL
       hire_date DATE(50) DEFAULT NULL
       gender VARCHAR(50) DEFAULT NULL
       birth_date VARCHAR(50) DEFAULT NULL
       ) ENGINE=InnoDB
       '''

cursor.execute(sql)

sql = '''CREATE TABLE IF NOT EXISTS salaries (
       emp_no VARCHAR(50) DEFAULT NULL
       salary INTEGER(50) DEFAULT NULL
       from_date VARCHAR(50) DEFAULT NULL
       to_date VARCHAR(50) DEFAULT NULL
       ) ENGINE=InnoDB
       '''
 
cursor.execute(sql)

tomorrow = datetime.now().date() + timedelta(days=1)

add_employee = ("INSERT INTO employees "
               "(first_name, last_name, hire_date, gender, birth_date) "
               "VALUES (%s, %s, %s, %s, %s)")
add_salary = ("INSERT INTO salaries "
              "(emp_no, salary, from_date, to_date) "
              "VALUES (%(emp_no)s, %(salary)s, %(from_date)s, %(to_date)s)")

data_employee = ('Geert', 'Vanderkelen', tomorrow, 'M', date(1977, 6, 14))

# Insert new employee
cursor.execute(add_employee, data_employee)
emp_no = cursor.lastrowid

# Insert salary information
data_salary = {
  'emp_no': emp_no,
  'salary': 50000,
  'from_date': tomorrow,
  'to_date': date(9999, 1, 1),
}
cursor.execute(add_salary, data_salary)

# Make sure data is committed to the database
cursor.commit()

#Execute SQL select statement
cursor.execute("SELECT * FROM employees")
cursor.close()
db.close()


   
      






