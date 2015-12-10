###########################################################################
#File: import-csv-ldap.sh 
#Purpose: This will import the exported users (alpha1-users.csv) from the   
###### LDAP Server database to a shibboleth table in the Alpha-1 i2b2  
###### Database and append new  users to the i2b2pm.pm_user_data and 
###### i2b2pm.pm_project_user_roles tables. This will be owned and run by 
###### the oracle user. 
#Cron Job: This will run every night at 2230.
#Work Flow: export-alpha1-csv.sh >>> load-alpha1-csv.sh >>> 
###### >>> createi2b2user-job > createi2b2user-procedure   
###########################################################################
#!/bin/bash

# Define Oracle Variables
export ORACLE_SID=I2BALPHA
export ORACLE_HOME=/oracle/app/product/12.1.0
export PATH=$ORACLE_HOME/bin:$PATH

#This will truncate the shibboleth.shibboleth table and insert the users
#from the alpha1-users.csv file into the shibboleth table

#Run sqlldr to load the shibboleth table with the users.csv
sqlldr user/pass control=shibboleth.ctl
