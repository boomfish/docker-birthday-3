#! /usr/bin/make


DOCKERMACHINE_ALL=bday-a2 bday-a1 bday-p1 bday-p2 bday-m1
DOCKERMACHINE_CLUSTER_OPTS="--swarm --swarm-image swarm:1.2.3 --swarm-discovery consul://192.168.99.10:8500/swarm --engine-opt cluster-store=consul://192.168.99.10:8500/swarm --engine-opt cluster-advertise=eth1:2376"
REXRAY_DOCKERMACHINE_LIST=bday-a1 bday-a2
VBOX_VOLUMEPATH=$(PWD)/rexray
REXRAY_PACKAGE=stable
REXRAY_VERSION=latest
VBOXWEBSRV_PIDFILE=/tmp/vboxwebsrv.pid

help:
		@echo "Help is on its way"

machines:	configure_vboxserv kvserv create_swarm setup_rexray

start:		start_vboxserv start_swarm

deploy:		start
			eval `docker-machine env --swarm bday-m1` && docker-compose -f ../docker-compose.yml up -d


undeploy:	start
			eval `docker-machine env --swarm bday-m1` && docker-compose -f ../docker-compose.yml down

stop:		stop_swarm stop_kvserv stop_xboxserv


cleanup:	cleanup_swarm cleanup_kvserv cleanup_vboxserv cleanup_interlock_keys


kvserv:
			./setup-discovery.sh

stop_kvserv:
			./stop-discovery.sh

cleanup_kvserv:
			./cleanup-discovery.sh


create_swarm:	kvserv
			./setup-cluster.sh

start_swarm:	kvserv create_swarm setup_rexray interlock_keys
			./start-cluster.sh

stop_swarm:
			./stop-cluster.sh

cleanup_swarm:
			./cleanup-cluster.sh



configure_vboxserv:
			./setup-vboxserv.sh

start_vboxserv:	configure_vboxserv
			./start-vboxserv.sh

stop_vboxserv:
			./stop-vxboxserv.sh


setup_rexray:
			mkdir -p $(VBOX_VOLUMEPATH)
			for m in $(REXRAY_DOCKERMACHINE_LIST); do ./setup-rexray.sh $$m $(VBOX_VOLUMEPATH) $(REXRAY_PACKAGE) $(REXRAY_VERSION); done

cleanup_rexray:
			./cleanup-rexray.sh


interlock_keys:
			./setup-interlock-ssl.sh

cleanup_interlock_keys:
			./cleanup-interlock-ssl.sh
