#!/usr/bin/bash

docker run -d \
  --name mysql \
  --restart always \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  --network laravel-service \
  mysql:lts

docker run -d \
  --name mailpit \
  --restart unless-stopped \
  -p 8025:8025 \
  -p 1025:1025 \
  axllent/mailpit

docker run -d \
  --name phpmyadmin \
  --restart unless-stopped \
  -p 8080:80 \
  -v mysql-data:/var/lib/mysql \
  -e PMA_USER=root \
  -e PMA_HOST=mysql \
  -e PMA_PORT=3306 \
  --network laravel-service \
  phpmyadmin/phpmyadmin:latest
