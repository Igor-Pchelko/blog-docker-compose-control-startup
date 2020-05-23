#!/bin/bash

# Wait 60 seconds for SQL Server to start up by ensuring that 
# calling SQLCMD does not return an error code, which will ensure that sqlcmd is accessible
# and that system and user databases return "0" which means all databases are in an "online" state
# https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-2017 

echo "Start database configuration"
ls -la /tmp

# sleep 30s
i=0
COMPLETED=0

while [[ $COMPLETED -ne 1 ]] && [[ $i -lt 60 ]]; do
  i=$((i + 1))
  COMPLETED=1
	DBSTATUS=$(/opt/mssql-tools/bin/sqlcmd -h -1 -t 1 -U sa -P ${SA_PASSWORD} -Q "SET NOCOUNT ON; Select SUM(state) from sys.databases")
	ERRCODE=$?

  if [[ $DBSTATUS -ne 0 ]]; then
    COMPLETED=0
  fi

  if [[ $ERRCODE -ne 0 ]]; then
    COMPLETED=0
  fi

	sleep 1
done

if [[ $COMPLETED -ne 1 ]]; then 
	echo "SQL Server took more than 60 seconds to start up or one or more databases are not in an ONLINE state"
	exit 1
fi

# Run the setup script to create the DB and the schema in the DB
cd /tmp/scripts ;
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -Q "CREATE DATABASE [$DATABASE]" ;
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -d ${DATABASE} -i/tmp/scripts/_main.sql ;

python ./readiness.py 1444

echo "Configuration complete"
