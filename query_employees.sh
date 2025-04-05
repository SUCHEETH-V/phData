#!/bin/bash

# Load secret from AWS Secrets Manager
SECRET_ID="mysql-secrets"
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$SECRET_ID" --query SecretString --output text)

# Extract credentials from JSON
DB_HOST=$(echo "$SECRET_JSON" | jq -r .host)
DB_PORT=$(echo "$SECRET_JSON" | jq -r .port)
DB_USER=$(echo "$SECRET_JSON" | jq -r .username)
DB_PASS=$(echo "$SECRET_JSON" | jq -r .password)
DB_NAME="employees"

# Define the query
QUERY="SELECT emp_no, first_name, last_name FROM employees LIMIT 10;"

# Run the query securely
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$QUERY"

