# Start the script to create the DB and user
cd /tmp/scripts
bash ./configure-db.sh &

# Start SQL Server
/opt/mssql/bin/sqlservr
