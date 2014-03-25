#!/bin/bash
# =============================================================================
# cvs 2 git migration script
# this script take a cvs repo and migrate it to git
# args:
# $1: the name of the cvs project to migrate
# $2: the name of the new project (eq to $1 if not provided)
# =============================================================================

delimiter_line="==========================================================================="

if [ $# == 0 ]
then
        echo "error: missing cvs project to migrate"
        exit
fi

cvs_project=$1
git_project=$2

if [ $# == 1 ]
then
        git_project=$cvs_project
fi

echo $delimiter_line
echo "cvs project to migrate: $cvs_project"
echo "git project: $git_project"


# copy cvs source (rsync does not work with msauchy - maybe a version problem)
echo $delimiter_line
echo "copy cvs project source"
echo $delimiter_line
scp -r d_chdomas@msauchy:/msauchy/appli/cvs/$cvs_project .

echo $delimiter_line
echo "copy cvs root"
echo $delimiter_line
scp -r d_chdomas@msauchy:/msauchy/appli/cvs/CVSROOT .

# launch cvs2git tool -> that will create 2 files: cvs2git.blob and cvs2git.dump
echo $delimiter_line
echo "launch cvs2git tool"
echo $delimiter_line
./cvs2svn-2.4.0/cvs2git --blobfile $cvs_project.blob --dumpfile $cvs_project.dump --username 'cvs2git' --encoding='iso-8859-1' --retain-conflicting-attic-files $cvs_project

# create the git folder
echo $delimiter_line
echo "create target folder and init git"
echo $delimiter_line
mkdir $git_project-git
cd $git_project-git
git init

echo $delimiter_line
echo "import the exported files into the git folder"
echo $delimiter_line
cat ../$cvs_project.{blob,dump} | git fast-import

echo $delimiter_line
echo "push to remote git repo"
echo $delimiter_line
git remote add origin ssh://gitosis@northdev/etp/$git_project.git
git push origin master
git push origin --all
git push origin --tags

