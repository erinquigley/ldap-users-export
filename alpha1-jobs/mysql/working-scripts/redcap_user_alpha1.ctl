LOAD DATA INFILE 'alpha1-users.csv'
INTO TABLE redcap_user_information
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@eppn,@givenname,@sn)
SET username=@eppn,
    user_email=@eppn,
    user_firstname=@givenname,
    user_lastname=@sn
    ;
