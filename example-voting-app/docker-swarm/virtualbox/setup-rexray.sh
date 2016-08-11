#!/bin/sh

set -e


# Setup rexray server on Docker VM for db-store
REXRAY_DOCKERMACHINE=$1
VBOX_VOLUMEPATH=${2:-/tmp/rexray}
REXRAY_PACKAGE=${3:-stable}
REXRAY_VERSION=${4:-latest}

[ "`docker-machine status $REXRAY_DOCKERMACHINE`" = "Running" ] || docker-machine start $REXRAY_DOCKERMACHINE

if docker-machine ssh $REXRAY_DOCKERMACHINE test -x /usr/bin/rexray; then
  echo "rexray: already installed on $REXRAY_DOCKERMACHINE"
else
  # Download and install rexray
  [ -f /tmp/rexray-install.sh ] || /tmp/curl -L -o /tmp/rexray-install.sh https://dl.bintray.com/emccode/rexray/install
  docker-machine scp /tmp/rexray-install.sh ${REXRAY_DOCKERMACHINE}:/home/docker/
  docker-machine ssh $REXRAY_DOCKERMACHINE "chmod u+x /home/docker/rexray-install.sh && /home/docker/rexray-install.sh ${REXRAY_PACKAGE} ${REXRAY_VERSION}"
fi

if docker-machine ssh $REXRAY_DOCKERMACHINE test -f /etc/rexray/config.yml; then
  echo "rexray: already configured on $REXRAY_DOCKERMACHINE"
else
  # Upload config.yml
  docker-machine scp rexray-config.yml ${REXRAY_DOCKERMACHINE}:/home/docker/
  docker-machine ssh $REXRAY_DOCKERMACHINE "sed 's#/tmp/rexray#${VBOX_VOLUMEPATH}#g' /home/docker/rexray-config.yml > /home/docker/config.yml"
  docker-machine ssh $REXRAY_DOCKERMACHINE sudo mkdir -p /etc/rexray
  docker-machine ssh $REXRAY_DOCKERMACHINE sudo cp /home/docker/config.yml /etc/rexray/config.yml
fi
