#!/bin/bash
#todo:  give dir from grails script
DIR=/home/user/manga/trunk/notify
export FILE_BASE=$DIR/work
export FILE_UPLOAD=$DIR/upload.files
PARAMS_UPLOAD=$DIR/upload.params
cd $DIR
echo "Running daemon..."
#todo: test pid existens
#      run only then process is not exist
#      stop demon on exit
killall inoticoming 
rm -rf $DIR/work/*
rm -rf $DIR/var/logs/*
rm $DIR/var/inoticoming.log
inoticoming --logfile var/inoticoming.log --pid-file var/inoticoming.pid \
$PARAMS_UPLOAD --stdout-to-log --stderr-to-log --chdir $DIR \
./parse.sh upload.params/{} \;
