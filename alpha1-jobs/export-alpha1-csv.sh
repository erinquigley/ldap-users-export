########################################################################
#Script Name: export-alpha1-csv.sh
#Purpose: Executes the perl script ldap-csvexport.pl to export LDAP 
###### users created each day to a csv file (alpha1-users.csv). Then
###### the alpha1-users.csv is scp to the i2b2db server to the Oracle
###### users home directory where it will be loaded into the database.
#Cron Job: This will run every night at 2200.
###### 00  22  *  *  * /home/ecq/export-alpha1-csv.sh
#Work Flow: export-alpha1-csv.sh >>> load-alpha1-csv.sh >>> 
###### >>> createi2b2user-job > createi2b2user-procedure  
########################################################################
#!/bin/sh
now=$(date  "+%Y%m%d")
base='ou=users,dc=alphaoneregistry,dc=org'
attributes='eduPersonPrincipalName,givenName,sn'
#refresh_job='/home/ecq/export-alpha1-users.log'

#Command to export ALL Alpha-1 users
#./ldap-csvexport.pl -a $attributes -b $base -s , > alpha1-users.csv

#Export Alpha-1 users by the account's creation timestamp
./ldap-csvexport.pl -a $attributes -b $base -f '(createtimestamp>='$now'000000Z)' -s , > alpha1-users.csv

#if [ $? -eq 0 ]; then 
#    echo 'CSV of Alpha-1 LDAP users was created successfully' >> $refresh_job
#    mail -s 'CSV of Alpha-1 LDAP users was created successfully' quigleye@musc.edu

#Transfer alpha1-users.csv to Alpha-1 database servers
scp alpha1-users.csv oracle@bmic-alpha1-i2b2db-d.obis.musc.edu:/home/oracle/alpha1-users
scp alpha1-users.csv user@bmic-alpha1-db-v.mdc.musc.edu:/home/user/alpha1-users

#    if[ $? -eq 0 ]; then 
#      echo 'scp of Alpha-1 LDAP users was successful' >> $refresh_job
#      mail -s 'scp of Alpha-1 LDAP users was successful' quigleye@musc.edu
#    else
#      echo 'scp of Alpha-1 LDAP users failed' >> $refresh_job
#      mail -s 'scp of Alpha-1 LDAP users failed' quigleye@musc.edu
#    fi
#else
#    echo 'CSV export of Alpha-1 LDAP users failed' >> $refresh_job
#    mail -s 'CSV export of Alpha-1 LDAP users failed' quigleye@musc.edu
#fi
