#!/bin/bash

set -x

# load cached images to docker
if [ -e docker_cache/docker-images.tar.gz ]; then 
  gunzip docker_cache/docker-images.tar.gz | docker load
fi
