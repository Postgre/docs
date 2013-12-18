#!/bin/bash
. /export/home/madev/.profile

#-----------------------------------------------------------------------------------------------
# panama batch - import log files in database
#-----------------------------------------------------------------------------------------------

echo "start import"
ant -f /export/apps/panama/panama-batch/build.xml $1
