#!/bin/bash

# Step 1: Download the docker-compose.yml file
wget https://goauthentik.io/docker-compose.yml -O docker-compose.yml

# Step 2: Create the .env file and generate environment variables
echo "Generating .env file..."

# Generate a random password for PostgreSQL
#PG_PASS=$(openssl rand -base64 36 | tr -d '\n')
#echo "PG_PASS=$PG_PASS" >> .env


# You can also use openssl instead: `openssl rand -base64 36`
apt-get install -y pwgen
# Because of a PostgreSQL limitation, only passwords up to 99 chars are supported
# See https://www.postgresql.org/message-id/09512C4F-8CB9-4021-B455-EF4C4F0D55A0@amazon.com
echo "PG_PASS=$(pwgen -s 40 1)" >> .env




# Generate a random secret key for Authentik
AUTHENTIK_SECRET_KEY=$(openssl rand -base64 60 | tr -d '\n')
echo "AUTHENTIK_SECRET_KEY=$AUTHENTIK_SECRET_KEY" >> .env

# Enable error reporting
echo "AUTHENTIK_ERROR_REPORTING__ENABLED=true" >> .env


docker compose up -d --remove-orphans

echo ".env file created successfully!"

docker compose up -d

docker compose up -d --remove-orphans

echo "Authentik started successfully!"

docker compose -f nmp.yml up -d

echo "NGINX Proxy Manager started successfully!"


