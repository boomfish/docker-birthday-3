#!/bin/sh

set -e

[ `docker-machine status bday-m1` = "Running" ] || docker-machine start bday-m1
[ `docker-machine status bday-a1` = "Running" ] || docker-machine start bday-a1
[ `docker-machine status bday-a2` = "Running" ] || docker-machine start bday-a2
[ `docker-machine status bday-p1` = "Running" ] || docker-machine start bday-p1
[ `docker-machine status bday-p2` = "Running" ] || docker-machine start bday-p2

eval $(docker-machine env --swarm bday-m1)

# Configure interlock via consul for:
#  - listening to the Docker swarm event stream
#  - querying the Docker swarm TCP endpoint for container info
curl -sS http://192.168.99.10:8500/v1/kv/interlock/v1/config -XDELETE | grep -q "^true$"
curl -sS http://192.168.99.10:8500/v1/kv/interlock/v1/config -XPUT -d "ListenAddr = \":8080\"
DockerURL = \"$DOCKER_HOST\"
TLSCACert = \"/var/lib/boot2docker/ca.pem\"
TLSCert = \"/etc/interlock/cert.pem\"
TLSKey = \"/etc/interlock/key.pem\"
AllowInsecure = false

[[Extensions]]
  Name = \"nginx\"
  ConfigPath = \"/etc/nginx/nginx.conf\"
  PidPath = \"/etc/nginx/nginx.pid\"
  MaxConn = 1024
  Port = 80" | grep -q "^true$"


for machine in bday-m1 bday-a1 bday-a2 bday-p1 bday-p2; do
  docker-machine ssh $machine mkdir -p /home/docker/interlock
  docker-machine scp interlock/certs/cert.pem $machine:interlock/
  docker-machine scp interlock/certs/key.pem $machine:interlock/
done


echo 'To connect your Docker Client to this Docker Swarm cluster, run:'
echo ''
echo '    eval $(docker-machine env --swarm bday-m1)'