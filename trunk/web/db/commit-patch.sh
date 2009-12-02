#!/bin/bash
cd ..
svn up
cd db
./schema-dump.sh > /dev/null
./test-patch.sh > /dev/null
if [[ $? > 0 ]]; then
    echo not ready for release
else
   REV=`svn info | grep '^Revision' | sed -e 's/Revision: *//'`
   echo committing new patch for revision $REV
   svn cp patch.sql patches/patch-to-rev$REV.sql
   echo -- from revision $REV > patch.sql
   cp schema-new.sql schema.sql
   svn ci -m "Patch to revision $REV released"
fi
