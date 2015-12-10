create table temp_redcap_user_info (
     username       varchar2(50),
     user_email     varchar2(50),
     user_firstname varchar2(50),
     user_lastname  varchar2(50)
     );

LOAD DATA INFILE 'alpha1-users.csv'
INTO TABLE temp_redcap_user_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
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
