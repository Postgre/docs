#!/bin/bash

# =============================================================================
# shutdown a tomcat instance
# =============================================================================

set +x
ENV=$1
INSTANCE=$2

# build the tomcat instance path
export CATALINA_BASE=/slbafrdvpap01/appli/$ENV/tomcat-$INSTANCE
export CATALINA_HOME=/slbafrdvpap01/appli/tomcat

$CATALINA_HOME/bin/shutdown.sh
