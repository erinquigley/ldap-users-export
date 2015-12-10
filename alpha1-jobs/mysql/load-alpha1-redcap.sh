########################################################################
#Script Name: load-alpha1-redcap.sh
#Purpose: Loads the alpha1-users.csv file into the Alpha-1 REDCap DB 
###### table redcap_user_information. It uses a LOAD DATA INFILE 
###### command. All users inserted will be defaulted to normal users..
#Cron Job: This will run every night at 2205.
###### 05  15  *  *  * /home/ecq/load-alpha1-redcap.sh
#Work Flow: export-alpha1-csv.sh >>> load-alpha1-redcap.sh   
########################################################################
#!/bin/bash

mysql -u ecq -ppassword123 <<EOF
use REDCap_SP_test;
CREATE TABLE temp_redcap_user_info (
     username       varchar(50),
     user_email     varchar(50),
     user_firstname varchar(50),
     user_lastname  varchar(50)
     );

LOAD DATA LOCAL INFILE '/path/to/alpha1-users.csv'
INTO TABLE temp_redcap_user_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
IGNORE 1 LINES
(@eppn,@givenname,@sn)
SET username=@eppn,
    user_email=@eppn,
    user_firstname=@givenname,
    user_lastname=@sn
    ;

INSERT INTO redcap_user_information (username,user_email,user_firstname,user_lastname)
 SELECT t.username,t.user_email,t.user_firstname,t.user_lastname FROM temp_redcap_user_info AS t
 WHERE NOT EXISTS (SELECT 1 FROM redcap_user_information AS r WHERE r.username = t.username);

DROP TABLE temp_redcap_user_info;

EOF
