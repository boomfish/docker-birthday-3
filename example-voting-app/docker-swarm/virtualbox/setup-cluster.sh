#!/bin/sh

set -e

DOCKERMACHINE_CLUSTER_OPTS="--swarm --swarm-image swarm:1.2.3 --swarm-discovery consul://192.168.99.10:8500/swarm --engine-opt cluster-store=consul://192.168.99.10:8500/swarm --engine-opt cluster-advertise=eth1:2376"

# Swarm manager VM
echo -n bday-m1: ; docker-machine status bday-m1 || docker-machine create -d virtualbox ${DOCKERMACHINE_CLUSTER_OPTS} --swarm-master bday-m1
# Test Docker Swarm endpoint on manager
docker-machine env --swarm bday-m1 > /dev/null
# Swarm agent VMs
echo -n "bday-a1: "; docker-machine status bday-a1 || docker-machine create -d virtualbox ${DOCKERMACHINE_CLUSTER_OPTS} --engine-label="bday.db-store=true" --engine-label="bday.mq-host=true" bday-a1
echo -n "bday-a1: "; docker-machine status bday-a2 || docker-machine create -d virtualbox ${DOCKERMACHINE_CLUSTER_OPTS} --engine-label="bday.db-store=true" --engine-label="bday.mq-host=true" bday-a2
echo -n "bday-p1: "; docker-machine status bday-p1 || docker-machine create -d virtualbox ${DOCKERMACHINE_CLUSTER_OPTS} --engine-label="custom.role=public" bday-p1
echo -n "bday-p2: "; docker-machine status bday-p2 || docker-machine create -d virtualbox ${DOCKERMACHINE_CLUSTER_OPTS} --engine-label="custom.role=public" bday-p2
