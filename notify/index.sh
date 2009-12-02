#!/bin/bash

if [[ $# < 2 ]]; then
  echo "Usage: ./index.sh dir file"
  exit 1
fi
echo $0 $1 $2

DIR=$1
ARCH=$2
# --------------------------------
echo --- 1. creating folder $DIR
mkdir -p $DIR
# --------------------------------
echo --- 2. extract archive $ARCH
unrar e -o+ $ARCH $DIR/
if [[ $? > 0 ]]; then
  unzip -o -j $ARCH -d $DIR/
fi
if [[ $? > 0 ]]; then
  echo "can't unarchive"
exit 1
fi
# -------------------------------
echo --- 3. indexing folder $DIR
rename -f 's/[^a-zA-Z0-9\-_.\/]/_/g' $DIR/*
chmod a+r $DIR/*
for file in `ls $DIR`; do
  echo -e "$file\t`imageinfo --format --size --width --height --md5hash $DIR/$file`";
done > $DIR/.list.log;
# ------------------------------
echo --- 4. deleting file $ARCH
rm $ARCH
