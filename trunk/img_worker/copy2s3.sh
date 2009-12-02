#!/bin/bash
if [ $# != 3 ];then
  echo "Usage: ./copy2s3.sh file url-name TXT|PNG|JPEG"
  exit 1
fi
groovy -cp lib/groovy-xmlrpc-0.4.jar:lib/s3lib.jar groovy/Amazon.groovy $1 $2 $3
