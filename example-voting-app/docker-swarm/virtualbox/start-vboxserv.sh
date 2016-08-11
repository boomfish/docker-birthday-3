#!/bin/sh

set -e

if [ ! -f /tmp/vboxwebsrv.pid ] || ! (ps -p `cat /tmp/vboxwebsrv.pid` | grep -q vboxwebsrv); then
	vboxwebsrv -H 0.0.0.0 -v -b -P /tmp/vboxwebsrv.pid
else
	echo "vboxserv already running"
fi
