#/bin/bash

wget www.google.fr 2>> check_proxy.`whoami`

if [[ $? -ne 0 ]]; then
        echo "Proxy error"
        /data/nexus/send_mail.py "raphael.dumontier@natixis.com,taliane.tchissambou-ext@natixis.com" "[Nexus] proxy problem" "You must reinit generic account password, procedure is described here :

http://confluence.north.cib.net:8080/display/NORTHDEVteam/tools-admin-northdev
see FAQ section

"

else
        echo "Proxy OK"
fi

rm index.html* 2> /dev/null

