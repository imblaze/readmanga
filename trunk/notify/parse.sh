#!/bin/bash
cat $1 |
while read params; do
  echo processing $1
  ./process.sh $params > var/logs/`basename $1`.log
  echo deleting $1
  rm $1
done;
