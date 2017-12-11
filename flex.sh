#!/usr/bin/env bash

case "$1" in
  up)
    docker-compose up -d
  ;;
  cleanall)
    docker-compose stop
    docker rm -f flex_webapp flex_db
    docker rmi -f flex_webapp flex_db
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