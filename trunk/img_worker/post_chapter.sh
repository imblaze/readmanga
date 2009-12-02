#!/bin/bash
DIR=${1%/}
shift 1
DIR=$DIR/v$2ch$3
if [ -e "$DIR/.process.log" ]; then
  echo looks like folder already processed
  exit 1
fi
./reindex.sh $DIR -s
groovy -cp lib/groovy-xmlrpc-0.4.jar groovy/PostChapter.groovy "$1" $2 $3 "`cat $DIR/.list.log`" | tee $DIR/.process.log
