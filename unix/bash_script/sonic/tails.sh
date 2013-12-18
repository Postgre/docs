#!/bin/bash
# java -cp lib/*:conf -Xdebug -Xrunjdwp:transport=dt_socket,server=y,address=8000 north.marketaccess.sonic.tails.Tails 
java -cp lib/*:conf north.marketaccess.sonic.tails.Tails 
