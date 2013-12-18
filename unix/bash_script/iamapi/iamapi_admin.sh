#!/bin/bash
# =============================================================================
# script to admin an iamapi server that use SMART "admin" script
# =============================================================================
. /export/home/madev/.profile

# launch admin script with iamapi args (we keep admin script identical to what SMART use)
function launch {
	$APPS_HOME/bin/admin iamapi-server $IAMAPI_OWNER $VERSION $COMMAND $COMMAND_ARG 
}


# set and pass args to a generic admin script
IAMAPI_OWNER=$1
VERSION=$2
COMMAND=$3
COMMAND_ARG=$4
case $COMMAND in
	conf)
		if [[ "$VERSION" > "4.1" ]]
		then
			# new conf layout
			case $COMMAND_ARG in
				driver-fix)
					COMMAND_ARG="driver/fix/iamapi-driver-fix.properties"
				;;
				
				driver-ims)
					COMMAND_ARG="driver/ims/iamapi-driver-ims.properties"
				;;

				server-fix)
					COMMAND_ARG="server/fix/fix-server.properties"
				;;

				server-ice)
					COMMAND_ARG="server/ice/iamapi-server-ice.properties"
				;;

				*)
					COMMAND_ARG="driver/ims/iamapi-driver-ims.properties"
				;;
			esac
		else
			# old all-in-one file conf
			COMMAND_ARG="iamapi_server.properties"
		fi
	;;

        log)
                COMMAND_ARG="iamapi.log"
        ;;

	clean)
		COMMAND_ARG="temp"
	;;
	
        recovery)
                COMMAND="start"
		COMMAND_ARG="runRecovery.xml"
        ;;

        fix-start)
                COMMAND="start"
		COMMAND_ARG="runFixServer.xml"
        ;;

	restart)
		# first launch a restart
		launch
		# second launch a log command
		COMMAND="log"
		COMMAND_ARG="iamapi.log"
		
esac

launch

