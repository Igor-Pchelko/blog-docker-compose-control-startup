cd /tmp ;
wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
(echo "080e61a7de8f2dc77b4a2bb772fab18d wait-for-it.sh" | md5sum -c -)
chmod u+x wait-for-it.sh
./wait-for-it.sh mssql:1444 && sleep 5

echo "Ready to operate"

/opt/mssql-tools/bin/sqlcmd -S mssql -U sa -P ${SA_PASSWORD} -d ${DATABASE} -i/tmp/scripts/_main.sql ;

echo "Done"
