#!/bin/sh

docker-machine create -d virtualbox --engine-opt="cluster-store=consul://192.168.99.10:8500/overlay" --engine-opt="cluster-advertise=eth1:2376" --engine-label="com.example.db-store=true" bday-server
