#!/bin/sh

docker-machine start bday-manager
docker-machine start bday-worker-1
docker-machine start bday-worker-2
docker-machine start bday-dbserver

echo 'To connect to the Docker Swarm cluster run:'
echo ''
echo '    eval $(docker-machine env --swarm bday-manager)'
