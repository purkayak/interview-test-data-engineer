#!/usr/bin/python

import MySQLdb as mdb 
 
import datetime, time
 
def run_sql_file(filename, connection):

    '''
    The function will take SQL script and a connection as input
    and will run the SQL query on the given connection  
    '''
    start = time.time()
    
    file = open(filename, 'r')
    sql = s = " ".join(file.readlines())
    #print "Start executing: " + filename + " at " + str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M")) + "\n" + sql 
	print "Start executing: " + filename + " at " + str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M")) + "\n"
    cursor = connection.cursor()
    cursor.execute(sql)    
    connection.commit()
    
    end = time.time()
    print "Time elapsed to run the query:"
    print str((end - start)*1000) + ' ms'
    
    
 
def main():    
    connection = mdb.connect('127.0.0.1', 'root', 'password', 'database_name')
    run_sql_file("db_load.sql", connection)    
	run_sql_file("Reporting.sql", connection) 
    connection.close()
    
if __name__ == "__main__":
    main()