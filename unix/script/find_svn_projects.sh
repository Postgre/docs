#! /bin/bash
# =============================================================================
# find all svn project
# args (opt): the directory to scan - current dir if no arg provide
# =============================================================================
set +x
if [ $# != 1 ] 
then
	# no-arg use current fit
	scan_dir=$(pwd)
else
	scan_dir=$(readlink -f $1)
fi

echo "dir to scan: " $scan_dir

IFS=$'\n'
for f in $(find $scan_dir -name "*.svn") ; do
	# extract project path (remove ".svn" string)
	svn_project=${f:0:${#f}-4}
	cd $(readlink -f $svn_project)

	# check if there are uncommited files
    url=$(svn info | grep "^URL") 

	if [[ $url == */trunk ]]; then
		echo "==============================================================================="
		url=$(echo $url | sed -nr "s|URL: (.*)/trunk|\1|p")
		echo "url: $url"
		echo "- trunk: $url/trunk"
		echo "- branches:"
		svn ls "$url/branches"
		echo "- tags:"
		svn ls "$url/tags"
	fi

	cd $scan_dir
done
