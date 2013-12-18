#!/bin/bash

# awk '{print $2}' --> take the second token of the line
PID=`ps -eo pid,args | grep "nexus-oss-webapp" | grep -v grep | awk '{print $1}'`
NICE=`ps -eo nice,args | grep "nexus-oss-webapp" | grep -v grep | awk '{print $1}'`

if [[ -z "$PID" ]]; then
        echo "HB: Nexus: DOWN"
else
        echo "HB: Nexus: UP"
        echo "Pid: $PID"
        echo "Nice: $NICE"
        VERSION=`ls -al nexus | awk '{print $11}' | sed "s/nexus-oss-webapp-//" | sed "s/\///"`
        echo "Version: $VERSION"
        echo "Url: http://northdev:8081/nexus"
        echo "server.url: http://northdev:8081/nexus"
        echo "Responsable: Christophe Domas"
        echo "Suppleant: Joel Costigliola"
fi

# Check Proxy

wget www.google.fr 2>> /tmp/check_proxy.`whoami`

if [[ $? -ne 0 ]]; then
        echo "HB: Proxy: DOWN"
else
        echo "HB: Proxy: UP"
fi

