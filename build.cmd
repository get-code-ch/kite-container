@echo off

rem stop and remove container and image
rem docker stop kite-container_kite-server_1
rem docker rm kite-container_kite-server_1
rem docker rmi kite-container_kite-server_1

rem rebuild postfix image and run container
docker-compose up -d --build kite-server
