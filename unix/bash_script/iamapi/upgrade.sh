#!/bin/bash
# ==============================================================================
# script to migrate iamapi_server.properties to 4.1 format 
# usage: ./upgrade.sh <properties file>
# the script make a copy of the file before upgrading 
# ==============================================================================

# copy orginial file
cp $1 $1.sav`date +\%Y\%m\%d_\%H\%M\%S`

sed -i 's/iamapi_server.Endpoints/iamapi.server.ice.endpoint/g' $1
sed -i 's/iamapi_services/iamapi.server.services/g' $1

sed -i 's/storm_endpoints/storm.endpoint/g' $1
sed -i 's/storm_executions_topic/storm.topic.exec/g' $1
sed -i 's/storm_order_events_topic/storm.topic.order/g' $1
sed -i 's/storm_market_connections_topic/storm.topic.marketconnection/g' $1

sed -i 's/storm_reconnection_strategy_tries/storm.reconnection.tries/g' $1
sed -i 's/storm_reconnection_strategy_baseperiod/storm.reconnection.baseperiod/g' $1
sed -i 's/storm_reconnection_strategy_periodfactor/storm.reconnection.periodfactor/g' $1
sed -i 's/storm_heartbeatperiod/storm.heartbeat.period/g' $1

sed -i 's/ims_reconnection_strategy_tries/ims.reconnection.tries/g' $1
sed -i 's/ims_reconnection_strategy_baseperiod/ims.reconnection.baseperiod/g' $1
sed -i 's/ims_reconnection_strategy_periodfactor/ims.reconnection.periodfactor/g' $1

sed -i 's/ims_config_list/ims.config.list/g' $1
sed -i 's/fix_config_list/fix.config.list/g' $1

sed -i 's/fix_data_dir/fix.data.dir/g' $1

sed -i 's/ims_url/ims.url/g' $1
sed -i 's/ims_login/ims.login/g' $1
sed -i 's/ims_password/ims.password/g' $1
sed -i 's/account_config_name/account.config.name/g' $1

sed -i 's/ims_dictdepth/ims.dict.depth/g' $1
sed -i 's/handle_events/event.handle/g' $1

sed -i 's/iamapi.server.services/iamapi.server.ice.services/g' $1

# delete old deprecated parameters
sed -i '/iamapi.server.ims.multi.same.route.enabled/d' $1
sed -i '/iamapiauthorized_user_filepath/d' $1
sed -i '/iamapiauthorized_mode/d' $1
sed -i '/use_authentication/d' $1
sed -i '/driver.client.spring.ice/d' $1

