#!/bin/bash

set -x

docker-compose up -d --build oracledb; docker-compose up --build waitoracledb
