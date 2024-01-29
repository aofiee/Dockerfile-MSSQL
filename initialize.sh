#!/bin/bash
INPUT_SQL_FILE="init.sql"

if [ ! -e "$INPUT_SQL_FILE" ]; then
  echo -e "File $INPUT_SQL_FILE not found"
  exit 1
else
  sed -i "s/CREATE DATABASE [a-zA-Z0-9_]*/CREATE DATABASE $MSSQL_DATABASE/" "$INPUT_SQL_FILE"
fi
until /opt/mssql-tools/bin/sqlcmd -S localhost,"$MSSQL_PORT" -U sa -P "$MSSQL_SA_PASSWORD" -i "$INPUT_SQL_FILE" > /dev/null 2>&1
do
  echo -e "SQL server is unavailable - sleeping"
  sleep 5
done
echo -e "Done initialize a database"