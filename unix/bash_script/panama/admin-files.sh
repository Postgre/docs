#!/bin/bash

#-----------------------------------------------------------------------------------------------
# panama batch - copy log files from smart server 
#-----------------------------------------------------------------------------------------------

echo "admin log files - input parameters: $*"

# check and process parameters
if [[ $# == 2 ]]
then
	DATE=$2
else
	DATE=$(date +%Y%m%d)
fi

# define vars
SRC=northp@slpeqs02:/export/logs/prod

# destination
FILE=/export/apps/panama/file
ROOT_DEST=$FILE/$DATE
IAMAPI_DEST=$ROOT_DEST/iamapi/
IMS_DEST=$ROOT_DEST/ims/
WASABI_DEST=$ROOT_DEST/wasabi/

case $1 in
clean) 
	echo "remove directory content: $FILE"
	rm -rvf $FILE/*
	;;

copy)
	# scp with key
	SCP="/usr/bin/scp -v -r -i /export/home/panama/.ssh/id_dsa"

	echo "copy parameters:"
	echo "	src: $SRC"
	echo "	date: $DATE"
	echo "	scp: $SCP"

	mkdir -p $IAMAPI_DEST $WASABI_DEST $IMS_DEST

	echo "------------------------------------------------------------------------------------------------"
	echo "copy iamapi logs into $IAMAPI_DEST"
	echo "------------------------------------------------------------------------------------------------"
	$SCP $SRC/iamapi/$DATE/* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_BOLT_euronext* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_ETF_multi* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_KWIKE_euronext* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_LISA_MULTI* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_Maggie_Multi* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_MOJO_multi* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_RAY4_gap3* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_RAY4_nws* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_RAY4_psa2* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_RAY4_psa* $IAMAPI_DEST
#	$SCP $SRC/iamapi/$DATE/iamapi_Scalp_multi* $IAMAPI_DEST

	echo "------------------------------------------------------------------------------------------------"
	echo "copy wasabi logs into $WASABI_DEST"
	echo "------------------------------------------------------------------------------------------------"
	$SCP $SRC/wasabi-server/$DATE/* $WASABI_DEST
#	$SCP $SRC/wasabi-server/$DATE/BOLT-euronext* $WASABI_DEST
#	$SCP $SRC/wasabi-server/$DATE/MOJO-multi* $WASABI_DEST
#	$SCP $SRC/wasabi-server/$DATE/Scalp-multi* $WASABI_DEST
#	$SCP $SRC/wasabi-server/$DATE/Maggie-Multi* $WASABI_DEST

	echo "------------------------------------------------------------------------------------------------"
	echo "copy ims logs into $IMS_DEST"
	echo "------------------------------------------------------------------------------------------------"
	$SCP $SRC/ims/$DATE/* $IMS_DEST
#	$SCP $SRC/ims/$DATE/cheuvreux_prod_bos_PerfRecord* $IMS_DEST
#	$SCP $SRC/ims/$DATE/eurex_prod_fullr7_PerfRecord* $IMS_DEST
#	$SCP $SRC/ims/$DATE/euronextUTP_bondLP_prod_bostransac_PerfRecord* $IMS_DEST
#	$SCP $SRC/ims/$DATE/euronextUTP_wasabi_prod_bostransac_PerfRecord* $IMS_DEST
#	$SCP $SRC/ims/$DATE/liffeUTP_fin_londres_prod_full_PerfRecord* $IMS_DEST
#	$SCP $SRC/ims/$DATE/lse-millennium_prod_bostransac_PerfRecord* $IMS_DEST
#	$SCP $SRC/ims/$DATE/mta-millennium_prod_bostransac_PerfRecord* $IMS_DEST
#	$SCP $SRC/ims/$DATE/xetra_prod_bosr9_PerfRecord* $IMS_DEST
	;;

*)
	echo "incorrect parameters - usage $0 (clean|copy) [yyyymmdd]"
	;;
esac

rm $IAMAPI_DEST/iamapi_LISA_MULTI*

echo "------------------------------------------------------------------------------------------------"
echo "concat split logs"
echo "------------------------------------------------------------------------------------------------"
/bin/sh /export/apps/panama/bin/concat-logs.sh $DATE
