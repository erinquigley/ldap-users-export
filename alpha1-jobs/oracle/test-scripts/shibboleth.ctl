OPTIONS ( skip=1 )
LOAD DATA
 INFILE 'shibboleth.csv'
 BADFILE 'shibboleth.bad'
 DISCARDFILE 'shibboleth.dsc'
 TRUNCATE INTO  TABLE shibboleth.shibboleth
 fields terminated by ","
 optionally enclosed by '"'
 trailing nullcols
  (user_id,
   first_name,
   last_name
   )
