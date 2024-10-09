!/bin/bash

docker compose stop
docker stop auto-npm-1
docker stop auto-npm-db-1
docker system prune

cp nmp.env .env

rm -rf certs/ custom-templates/ media/  npm/  npm-db/

docker compose up -d --remove-orphans

