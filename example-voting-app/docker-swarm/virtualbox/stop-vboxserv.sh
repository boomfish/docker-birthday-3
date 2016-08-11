#!/bin/sh

if [ -f /tmp/vboxwebsrv.pid ] && ps -p `cat /tmp/vboxwebsrv.pid` | grep -q vboxwebsrv; then
	kill `cat /tmp/vboxwebsrv.pid`
else
	killall vboxwebsrv
fi

rm -f /tmp/vboxwebsrv.pid
