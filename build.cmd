@echo off

rem stop and remove container and image
rem docker stop postfix_postfix_1
rem docker rm postfix_postfix_1
rem docker rmi postfix_postfix

rem rebuild postfix image and run container
docker-compose up -d --build kite-server
