#!/bin/bash
# =============================================================================
# deploy a conf into an env
# =============================================================================
set +x

ENV=$1
INSTANCE=$2


echo "-------------------------------------------------------------------------------"
echo "deploy - env: $ENV - instance: $INSTANCE - war: $WEBAPP"
echo "-------------------------------------------------------------------------------"
echo "shutdow tomcat instance"
echo ""
/slbafrdvpap01/appli/scripts/shutdown.sh $ENV $INSTANCE

echo "-------------------------------------------------------------------------------"
echo "sleep 5 secs"
echo ""
sleep 5

echo "-------------------------------------------------------------------------------"
echo "copy conf files"
echo ""
rsync -av /slbafrdvpap01/appli/webapps-conf/$ENV/ /slbafrdvpap01/appli/$ENV/


echo "-------------------------------------------------------------------------------"
echo "start tomcat instance"
echo ""
/slbafrdvpap01/appli/scripts/startup.sh $ENV $INSTANCE
