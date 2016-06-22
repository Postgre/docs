#!/bin/bash

# =============================================================================
# start a tomcat instance
# =============================================================================

set +x

ENV=$1
INSTANCE=$2

# build the tomcat instance path
export CATALINA_BASE=/slbafrdvpap01/appli/$ENV/tomcat-$INSTANCE
export CATALINA_HOME=/slbafrdvpap01/appli/tomcat

# remove old logs
rm $CATALINA_BASE/logs/*

# -----------------------------------------------------------------------------
# env variables 
# -----------------------------------------------------------------------------

# set a prefix port depending of env
case $ENV in
	dev)  JMX_PORT_PREFIX=309;;
	prex) JMX_PORT_PREFIX=308;;
esac
	
# set specific env var for each instance
case $INSTANCE in

activepivot)	
	JMX_PORT_SUFFIX=0
	if [ $ENV = "dev" ] 
	then
		# dev props
		JAVA_OPTS="-Xmx40g -Xms1g -XX:MaxDirectMemorySize=100g -Djava.net.preferIPv4Stack=true -XX:+UnlockCommercialFeatures -XX:+FlightRecorder"
	else
		JAVA_OPTS="-Xmx10g -Xms1g -XX:MaxDirectMemorySize=50g -Djava.net.preferIPv4Stack=true"
	fi
	;;
live)		
	JMX_PORT_SUFFIX=1
	JAVA_OPTS="-Xmx1g -Xms1g -Djava.net.preferIPv4Stack=true"
	;;
	
sentinel)	
	JMX_PORT_SUFFIX=2
	JAVA_OPTS="-Xmx1g -Xms1g -Djava.net.preferIPv4Stack=true"
	;;
esac

# build jmx port: prefix + suffix
JMX_PORT="$JMX_PORT_PREFIX$JMX_PORT_SUFFIX"

# jmx options
JMX_OPTS="-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=$JMX_PORT -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

# app dynamic options (to add to catalina)
APM_OPTS="-javaagent:/slbafrdvpap01/product/apm/appagent/javaagent.jar -Dappdynamics.controller.hostName=apm-tsv.qua.intranatixis.com -Dappdynamics.controller.port=80 -Dappdynamics.agent.nodeName=slbafrdvpap01_w55_activepivot_qua -Dappdynamics.agent.applicationName=w55_activepivot_QUA -Dappdynamics.agent.tierName=w55_$TOMCAT_INSTANCE_NAME"

# log gc
LOGC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:$CATALINA_BASE/logs/gc.log"

# add jmx options to catalina options
export CATALINA_OPTS="$CATALINA_OPTS $JAVA_OPTS $JMX_OPTS $LOGC_OPTS"
echo "start tomcat - base: $CATALINA_BASE - opts:$CATALINA_OPTS"

# go to tomcat bin and start tomcat
$CATALINA_HOME/bin/startup.sh

