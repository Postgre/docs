#!/bin/bash
# =============================================================================
# deploy a wabapp + conf into an env
# =============================================================================
set +x

ENV=$1
INSTANCE=$2

case $INSTANCE in
activepivot) 	
	WEBAPP=server
	;;
live)		
	WEBAPP=live
	;;
sentinell)	
	WEBAPP=snl
	;;
*) 	
	echo "unknown appli"
	exit
esac	

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
echo "remove old the web app dir"
echo ""
rm -r /slbafrdvpap01/appli/$ENV/tomcat-$INSTANCE/webapps/$WEBAPP

echo "-------------------------------------------------------------------------------"
echo "unzip web archive in the web app dir"
echo ""
unzip /slbafrdvpap01/appli/webapps/"$WEBAPP".war -d /slbafrdvpap01/appli/$ENV/tomcat-$INSTANCE/webapps/$WEBAPP

echo "-------------------------------------------------------------------------------"
echo "copy conf files"
echo ""
rsync -av /slbafrdvpap01/appli/webapps-conf/$ENV/ /slbafrdvpap01/appli/$ENV/

echo "-------------------------------------------------------------------------------"
echo "archive webapp to deployed dir"
echo ""
mv /slbafrdvpap01/appli/webapps/"$WEBAPP".war /slbafrdvpap01/appli/webapps/deployed/"$WEBAPP".war.$(date +"%Y%m%d_%H%M%S").$ENV

echo "-------------------------------------------------------------------------------"
echo "start tomcat instance"
echo ""
/slbafrdvpap01/appli/scripts/startup.sh $ENV $INSTANCE
