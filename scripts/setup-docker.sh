#!/bin/bash

set -x

# load cached images to docker
if [ -e docker_cache/docker-images.tar.gz ]; then 
  gunzip docker_cache/docker-images.tar.gz | docker load
fi

docker-compose up -d --build oracledb; docker-compose up --build waitoracledb

# build cached images
if [ ! -e docker_cache/docker-images.tar.gz ]; then 
  echo "Install oracle client libs to db container and copy to hosts ~/lib for node oracledb driver..."
  docker-compose exec oracledb curl http://yum.oracle.com/public-yum-ol7.repo -o /etc/yum.repos.d/public-yum-ol7.repo
  docker-compose exec oracledb yum install -y yum-utils
  docker-compose exec oracledb yum-config-manager --enable ol7_oracle_instantclient
  docker-compose exec oracledb yum install -y oracle-instantclient18.3-basiclite
  mkdir -p docker_cache
  docker save $(docker-compose config | awk '{if ($1 == "image:") print $2;}' ORS=" ") | gzip -c > docker_cache/docker-images.tar.gz
  ls -la docker_cache
fi

# copy drivers from docker image to travis
docker cp oracledbxe_container:/usr/lib/oracle/18.3/client64/lib/ $HOME/
sudo sh -c "echo $HOME/lib > /etc/ld.so.conf.d/oracle-instantclient.conf"
sudo ldconfig