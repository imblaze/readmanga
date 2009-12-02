#!/bin/bash
URL=http://i.readmanga.ru/$1
BASE_DIR=$1
DIR=$1/v$2ch$3
if [[ $# < 5 ]]; then
  echo "Usage: ./process.sh dir vol num manga_name urls|files"
  exit 1
fi
VOL=$2
NUM=$3
NAME=$4
shift 4
URLS="$@"

mkdir -p $DIR
echo "Dir: $DIR"
echo "Urls: $URLS"
for DURL in $URLS
do
  if [[ $DURL == http://* ]]
  then
    echo Downloading $DURL
    wget $DURL -O out.arh | tee $DIR/.wget.log;
  else 
    echo moving $DURL
    mv $DURL ./out.arh
  fi
  if [[ $? > 0 ]]; then
    echo "cant download"
    exit 1;
  fi
  unrar e -o+ out.arh $DIR/
  if [[ $? > 0 ]]; then
    unzip -o -j out.arh -d $DIR/
  fi
  if [[ $? > 0 ]]; then
    echo "can't unarchive"
  exit 1
  fi
done

./post_chapter.sh $BASE_DIR "$NAME" $VOL $NUM
