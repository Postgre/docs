#!/bin/bash
# =============================================================================
# restart all instance for dev env
# =============================================================================
./shutdown.sh dev activepivot
./shutdown.sh dev live
./shutdown.sh dev sentinel

echo "wait shutdown"
sleep 5

./startup.sh dev activepivot
./startup.sh dev live
./startup.sh dev sentinel

