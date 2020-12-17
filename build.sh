#!/bin/bash

## stop and remove container and image
docker stop kite-container_kite-server_1
docker rm kite-container_kite-server_1
docker rmi kite-container_kite-server
docker image prune -f


# rebuild kite-server image and run container
docker-compose up -d --build kite-server
