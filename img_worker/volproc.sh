#!/bin/bash
if [[ $# < 6 ]]; then
echo usage: ./volproc.sh volNum chapterBegin chapterEnd dir manga_name url
exit 1
fi
v=$1
cb=$2
ce=$3
dir=$4
name=$5
shift 5
url="$@"
for c in $(seq $cb $ce); do 
  URL=${url//\%v%/$v}
  URL=${URL//\%c%/$c}
  ./process.sh $dir ${v} ${c} "$name" $URL; 
done;
