#!/bin/sh

docker-machine create -d virtualbox --swarm --swarm-master --swarm-discovery="consul://192.168.99.10:8500/swarm" --engine-opt="cluster-store=consul://192.168.99.10:8500/swarm" --engine-opt="cluster-advertise=eth1:2376" bday-manager
docker-machine create -d virtualbox --swarm --swarm-discovery="consul://192.168.99.10:8500/swarm" --engine-opt="cluster-store=consul://192.168.99.10:8500/swarm" --engine-opt="cluster-advertise=eth1:2376" bday-worker-1
docker-machine create -d virtualbox --swarm --swarm-discovery="consul://192.168.99.10:8500/swarm" --engine-opt="cluster-store=consul://192.168.99.10:8500/swarm" --engine-opt="cluster-advertise=eth1:2376" bday-worker-2
docker-machine create -d virtualbox --swarm --swarm-discovery="consul://192.168.99.10:8500/swarm" --engine-opt="cluster-store=consul://192.168.99.10:8500/swarm" --engine-opt="cluster-advertise=eth1:2376" --engine-label="com.example.db-store=true" bday-dbserver

echo 'To connect to the Docker Swarm cluster run:'
echo ''
echo '    eval $(docker-machine env --swarm bday-manager)'

