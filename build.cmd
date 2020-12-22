@echo off

rem stop and remove container and image
docker stop kite-container_kite-server_1
docker rm kite-container_kite-server_1
docker rmi kite-container_kite-server
docker image prune -f

rem rebuild kite-server image and run container
docker-compose up --remove-orphans -d --build kite-server
docker cp setup.json kite-container_kite-server_1:/kite-server/config/setup.json