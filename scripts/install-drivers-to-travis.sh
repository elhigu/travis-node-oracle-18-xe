#!/bin/bash

set -x

# copy drivers from docker image to travis
docker cp oracledbxe_container:/usr/lib/oracle/18.3/client64/lib/ $HOME/
sudo sh -c "echo $HOME/lib > /etc/ld.so.conf.d/oracle-instantclient.conf"
sudo ldconfig