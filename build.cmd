@echo off

rem stop and remove container and image
docker stop kite-container_kite-server_1
docker rm kite-container_kite-server_1
rem docker rmi kite-container_kite-server
rem docker image prune -f

rem rebuild kite-server image and run container
docker-compose up -d --build kite-server
docker cp setup.json kite-container_kite-server_1:/kite-server/config/setup.json