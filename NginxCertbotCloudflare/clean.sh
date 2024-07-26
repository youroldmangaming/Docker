docker-compose down
docker network prune  # Be careful; this removes all unused networks
docker volume prune  # Be careful; this removes all unused volumes
docker system prune