#!/bin/sh

set -e -x

[ `docker-machine status bday-m1` = "Running" ] || docker-machine start bday-m1
[ `docker-machine status bday-a1` = "Running" ] || docker-machine start bday-a1
[ `docker-machine status bday-a2` = "Running" ] || docker-machine start bday-a2
[ `docker-machine status bday-p1` = "Running" ] || docker-machine start bday-p1
[ `docker-machine status bday-p2` = "Running" ] || docker-machine start bday-p2

echo 'To connect your Docker Client to this Docker Swarm cluster, run:'
echo ''
echo '    eval $(docker-machine env --swarm bday-m1)'