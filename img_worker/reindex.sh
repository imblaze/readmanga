#!/bin/bash
BASE=${1%/}
SUFFIX=${BASE##*/}
if [ "$2" = -s ]; then
  DIRS=$SUFFIX
  BS=$BASE
  BASE=${BS%/*}
  SUFFIX=${BASE##*/}
else
  DIRS=`ls $BASE`
fi

echo base: $BASE
echo url suffix: $SUFFIX
cd $BASE

for DIR in $DIRS; do  
  echo Indexing $DIR; 
#  rename -f 's/[ #]/_/g' $DIR/*
  rename -f 's/[^a-zA-Z0-9\-_.\/]/_/g' $DIR/*
  chmod a+r $DIR/*
  for file in `ls $DIR`; do 
    echo -e "$SUFFIX/$DIR/$file\t`imageinfo --format --size --width --height --md5hash $DIR/$file`"; 
  done > $DIR/.list.log; 
done;
