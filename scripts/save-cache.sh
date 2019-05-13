#!/bin/bash

set -x

# build cached images
if [ ! -e docker_cache/docker-images.tar.gz ]; then 
  mkdir -p docker_cache
  docker save $(docker-compose config | awk '{if ($1 == "image:") print $2;}' ORS=" ") | gzip -c > docker_cache/docker-images.tar.gz
fi
