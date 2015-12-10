OPTIONS ( skip=1 )
LOAD DATA
 INFILE '/home/oracle/alpha1-users/alpha1-users.csv'
 BADFILE '/home/oracle/alpha1-users/shibboleth.bad'
 DISCARDFILE '/home/oracle/alpha1-users/shibboleth.dsc'
 TRUNCATE INTO  TABLE shibboleth.shibboleth
 fields terminated by ","
 optionally enclosed by '"'
 trailing nullcols
  (user_id,
   first_name,
   last_name
   )
