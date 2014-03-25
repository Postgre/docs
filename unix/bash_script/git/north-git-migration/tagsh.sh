#!/bin/bash -e
#
# Usage:
# ./global.sh local-temp-name svn-path git-path
# Exemple:
# ./global.sh rtpose-server posedev/rtpose/rtpose-server posedev/rtpose/rtpose-server

nice -n 19 git svn clone -A authors-transform.txt --no-metadata -T trunk -b branches -t tags4  file:///data/csvn/data/repositories/north/$2 $1.git
./repack.sh $1

cd $1.repack.git
git remote add origin ssh://gitosis@northdev/$3.git
git push origin master
git push origin --all
git push origin --tags

