#!/bin/bash

DB_HOST=$1
DB_PORT=$2
DB_USER=$3
DB_PASS=$4
DB_NAME="employees"

QUERY="SELECT emp_no, first_name, last_name FROM employees LIMIT 10;"

mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$QUERY"
