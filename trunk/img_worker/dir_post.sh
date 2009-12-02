#!/bin/bash
if [ -e $1/.process.log ]; then
  echo looks like folder already processed
  exit 1
fi

./reindex.sh $1
groovy -cp lib/groovy-xmlrpc-0.4.jar:groovy/ groovy/dir_process.groovy $1 "$2" | tee $1/.process.log
