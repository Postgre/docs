#!/bin/bash

echo "------------------------------------------------------------------------------------------------"
echo "concat split logs"
echo "------------------------------------------------------------------------------------------------"

DIR="/export/apps/panama/file/$1"

# counter for $filesToConcat
i=0

for file in `ls -1 $DIR`; do
	for file2 in `ls -1 $DIR/$file`; do
		grepResult=`echo $file2 | grep -o ".*\.log"`
		if [ $grepResult ]; then
			# for each .log, we count the number of occurences
			count=`ls -1 $DIR/$file  | grep -c $grepResult`
			if [ $count -gt 1  ]; then
				isNew=1
				# we check if the current .log is already in $filesToConcat
				for ((j=0; j<i; j++)); do
					temp=`echo ${filesToConcat[j]} | grep -o ".*\.log"`
					if [ $temp  ]; then
						isNew=0
					fi
				done
				# the current .log is not already in $filesToConcat, so we add it
				# the number of occurences is added at the end
				if [ $isNew -eq 1 ]; then
					filesToConcat[$i]=$DIR/$file/$grepResult$count
					i=`expr $i + 1`
				fi
			fi
		fi
	done
done;

for ((k=0; k<i; k++)); do
	fileName=`echo ${filesToConcat[k]} | grep -o ".*\.log"`
	splitNumber=`echo ${filesToConcat[k]} | grep -Po "\d+$"`

	echo "concatenate "$fileName".*..."

	# the first file before splitting
	originFile=$fileName"."$(expr $splitNumber - 1)

	# we concatenate each .log.* >= 1 (if it's not the $originFile) with the $originFile, then we delete the .log.*
	for ((l=splitNumber-2; l>0; l--)); do
		currentFile=$fileName"."$l
		`cat $currentFile >> $originFile`
		`rm $currentFile` 
	done

	# we concatenate the .log file with the $originFile, then we delete the .log and rename the $originFile
	`cat $fileName >> $originFile`
	`rm $fileName`
	`mv $originFile $fileName`

	echo "...done"
done;

echo "concat result - files processed: "$i
