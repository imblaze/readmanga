#!/bin/bash
if [ $# != 2 ];then
  echo "Usage: ./copyFolder2s3.sh localPath prefix"
  exit 1
fi
groovy -cp lib/groovy-xmlrpc-0.4.jar:lib/s3lib.jar:groovy/ groovy/CopyToAmazon.groovy $1 $2 | tee $1$2/.amazon.log
