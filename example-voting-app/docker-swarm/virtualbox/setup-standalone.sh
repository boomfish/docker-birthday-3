#!/bin/sh

set -e

DOCKERMACHINE_CLUSTER_OPTS='--engine-opt="cluster-store=consul://192.168.99.10:8500/overlay" --engine-opt="cluster-advertise=eth1:2376"'

docker-machine create -d virtualbox ${DOCKERMACHINE_CLUSTER_OPTS} --engine-label="custom.role=public" --engine-label="bday.db-store=true" -engine-label="bday.mq-host=true" bday-server
