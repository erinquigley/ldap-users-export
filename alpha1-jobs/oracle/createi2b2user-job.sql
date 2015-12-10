BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"SHIBBOLETH"."CREATEI2B2USERS_JOB"',
            job_type => 'STORED_PROCEDURE',
            job_action => 'SHIBBOLETH.CREATEI2B2USER',
            number_of_arguments => 0,
            start_date => NULL,
            repeat_interval => 'FREQ=DAILY;BYDAY=MON,TUE,WED,THU,FRI,SAT,SUN;BYHOUR=23;BYMINUTE=0;BYSECOND=0',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Job to insert new Alpha-1 Users into i2b2 tables');

         
     
 
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"SHIBBOLETH"."CREATEI2B2USERS_JOB"', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
      
  
    
    DBMS_SCHEDULER.enable(
             name => '"SHIBBOLETH"."CREATEI2B2USERS_JOB"');
END;
