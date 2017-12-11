#!/usr/bin/env bash

case "$1" in
  up)
    docker-compose up -d
    docker exec -it flex_webapp demo/bin/init_demo
  ;;
  cleanall)
    docker-compose stop
    docker rm -f flex_webapp flex_db
    docker rmi -f symfony4php72_webapp
    docker ps && docker images | grep flex
  ;;
  clean)
    docker stop flex_webapp flex_db
    docker rm -f flex_webapp flex_db
    docker ps -a
  ;;
  stop)
    docker stop flex_webapp flex_db
  ;;
  *)
    echo 'Parameter not supported.'
  ;;
esac