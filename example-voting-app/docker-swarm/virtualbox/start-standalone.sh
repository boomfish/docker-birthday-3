#!/bin/sh

set -e

[ `docker-machine status bday-server` = "Running" ] || docker-machine start bday-server

# Configure interlock vua consul for:
#  - polling every 5 seconds
#  - querying the unix socket for container info
#  - forwarding all requests to the Docker host IP
curl -sS http://192.168.99.10:8500/v1/kv/interlock/v1/config -XDELETE | grep -q true
curl -sS http://192.168.99.10:8500/v1/kv/interlock/v1/config -XPUT -d "ListenAddr = \":8080\"
DockerURL = \"unix:///var/run/docker.sock\"
PollInterval = \"5s\"

[[Extensions]]
  Name = \"nginx\"
  ConfigPath = \"/etc/nginx/nginx.conf\"
  PidPath = \"/etc/nginx/nginx.pid\"
  BackendOverrideAddress = \"172.17.0.1\"
  MaxConn = 1024
  Port = 80" | grep -q true

echo 'To connect to the Docker server run:'
echo ''
echo '    eval $(docker-machine env bday-server)'
