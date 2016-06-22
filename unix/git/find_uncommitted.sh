#! /bin/bash
# =============================================================================
# find all uncommited filles
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
for f in $(find $scan_dir -name "*.git") ; do
	# extract project path (remove ".git" string)
        git_project=${f:0:${#f}-4}
	cd $(readlink -f $git_project)

	# check if there are uncommited files
        uncommited=$(git status --porcelain -z) 
	if [ -n "$uncommited" ]
	then 
		echo ""
		echo "============================================================="
		echo "git project found: " $git_project 
		echo "============================================================="
		# display uncommited files
		git status --porcelain
	fi

	cd $scan_dir
done
