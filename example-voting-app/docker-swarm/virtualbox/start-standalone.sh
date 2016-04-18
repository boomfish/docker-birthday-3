#!/bin/sh

docker-machine start bday-server

echo 'To connect to the Docker server run:'
echo ''
echo '    eval $(docker-machine env bday-server)'
