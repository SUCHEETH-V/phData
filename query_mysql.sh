#!/bin/bash

DB_USER=$1
DB_PASS=$2

mysql -h <EC2-PUBLIC-IP> -P 3307 -u "$DB_USER" -p"$DB_PASS" -e "SELECT * FROM employees.employees LIMIT 5;"
