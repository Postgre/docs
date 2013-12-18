#!/bin/bash
# =============================================================================
# stop a northmarket
# - find all processes that conatins nm-macao
# - remove the grep process from previous result
# - retrieve the PIDs (ant jmv + nm jvm)
# - kill them all 
# =============================================================================
ps -ef | grep $1 | grep -v "grep"  | cut -d' ' -f6 | xargs kill -9 
