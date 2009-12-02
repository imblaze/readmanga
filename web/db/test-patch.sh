#!/bin/bash
bin/recreate.sh
mysql -u root -proot mangat < schema.sql
mysql -u root -proot mangat < patch.sql
bin/dump.sh > schema-patched.sql
bin/diff.sh schema-patched.sql schema-new.sql> patched.diff
if [[ $? > 0 ]]; then
    cat patched.diff
    exit 1
else
    echo "patch successful"
    rm -f patch.diff patched.diff schema-patched.sql
fi
