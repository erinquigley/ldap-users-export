########################################################################
#Script Name: export-alpha1-csv.sh
#Purpose: Executes the perl script ldap-csvexport.pl to export LDAP 
###### users created each day to a csv file (alpha1-users.csv). Then
###### the alpha1-users.csv is scp to the i2b2db server to the Oracle
###### users home directory where it will be loaded into the database.
#Cron Job: This will run every night at 2200.
#Work Flow: export-alpha1-csv.sh >>> load-alpha1-csv.sh >>> 
###### >>> createi2b2user-job > createi2b2user-procedure  
########################################################################
#!/bin/sh

#Define a date  variable, this will be used to export only the users created during that day.
now=$(date  "+%Y%m%d")

#To export ALL users in LDAP database:
#./ldap-csvexport.pl -a cn,givenName,sn,createtimestamp -b ou=users,dc=obis,dc=musc,dc=edu -s , > alpha1-users.csv

#Use option -f (filter) to only export users created during that day
./ldap-csvexport.pl -a eduPersonPrincipalName,givenName,sn -b ou=users,dc=obis,dc=musc,dc=edu -f '(createtimestamp>='$now'000000.0Z)' -s , > alpha1-users.csv

if [ $? -eq 0 ]; then
    echo 'CSV of Alpha-1 LDAP users was created successfully' >> $refresh_job
    mail -s 'CSV of Alpha-1 LDAP users was created successfully' quigleye@musc.edu

#scp the csv file to the alpha-1 i2b2 database server
    scp alpha1-users.csv oracle@bmic-alpha1-i2b2db-d.obis.musc.edu:/home/oracle/alpha1-users

    if[ $? -eq 0 ]; then
      echo 'scp of Alpha-1 LDAP users was successful' >> $refresh_job
      mail -s 'scp of Alpha-1 LDAP users was successful' quigleye@musc.edu
    else
      echo 'scp of Alpha-1 LDAP users failed' >> $refresh_job
      mail -s 'scp of Alpha-1 LDAP users failed' quigleye@musc.edu
    fi
else
    echo 'CSV export of Alpha-1 LDAP users failed' >> $refresh_job
    mail -s 'CSV export of Alpha-1 LDAP users failed' quigleye@musc.edu
fi
