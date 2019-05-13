#!/bin/bash

set -x

# install client drivers to oracle docker image
if [ ! -e docker_cache/docker-images.tar.gz ]; then 
  echo "Install oracle client libs to db container and copy to hosts ~/lib for node oracledb driver..."
  docker-compose exec oracledb curl http://yum.oracle.com/public-yum-ol7.repo -o /etc/yum.repos.d/public-yum-ol7.repo
  docker-compose exec oracledb yum install -y yum-utils
  docker-compose exec oracledb yum-config-manager --enable ol7_oracle_instantclient
  docker-compose exec oracledb yum install -y oracle-instantclient18.3-basiclite
fi
