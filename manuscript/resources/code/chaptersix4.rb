   # create a SSH tunnel to RDS through your bastion:
   ssh -L 54320:your_rds_database_endpoint_here.your_region_here.rds.amazonaws.com:5432
       ec2-user@<bastion_public_ip>
       -i ./laravelaws.pem
  
   # Your remote database is now accessible from port 54320 on your local machine
   # I strongly recommend to create first thing a read-only user in your database
   psql -h localhost -p 54320 -U postgres -W db_name_here
   > CREATE ROLE lionel LOGIN PASSWORD 'a_unique_password_here';
   > GRANT CONNECT ON DATABASE crvs TO lionel;
   > GRANT USAGE ON SCHEMA public TO lionel;
   > GRANT SELECT ON ALL TABLES IN SCHEMA public TO lionel;
   > GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO lionel
 
   # You can then use pg_dump, pg_restore, or pgsql command line tools to create/restore a DB dump
   pg_dump -h localhost -U lionel -W -p 54320 db_name_here > dump_db_name_here_$(date +"%m_%d_%Y").sql
 
   # Import it into a local database using:
   psql -U lionel -w db_name_here -f dump_db_name_here_11_23_2017.sql
