#!/bin/bash
# =============================================================================
# script to test active pivot initial loading 
# =============================================================================
set +x
for i in {1..30}
do
	for j in 10 20 30 35 40
	do
		echo "shutdown active pivot"
		/slbafrdvpap01/appli/scripts/shutdown.sh dev activepivot

		echo "sleep until jmx port is available"
		until ! netstat -taupen | grep 3090	
		do
			sleep 5
		done
		

		echo "replace thread parser property"
		# replace the current number of threads by the one of the loop
		sed -i -r "s/(csvSource\.parserThreads=).*$/\1$j/" /slbafrdvpap01/appli/dev/tomcat-activepivot/webapps/server/WEB-INF/classes/sandbox.properties
		
		echo "loading test - thread count: $j"
		/slbafrdvpap01/appli/scripts/startup.sh dev activepivot


		echo "wait for end loading"
		until grep -q "org.apache.catalina.startup.Catalina.start Server startup in" /slbafrdvpap01/appli/dev/tomcat-activepivot/logs/catalina.out
		do
			sleep 10
		done

		echo "add log lines in result file"
		grep "org.apache.catalina.startup.Catalina.start Server startup in" /slbafrdvpap01/appli/dev/tomcat-activepivot/logs/catalina.out >> /slbafrdvpap01/appli/dev/bench-"$j".txt
		grep "Processing of workload" /slbafrdvpap01/appli/dev/tomcat-activepivot/logs/catalina.out >> /slbafrdvpap01/appli/dev/bench-"$j".txt
	done
done
