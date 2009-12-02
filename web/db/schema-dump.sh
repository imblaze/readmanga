#!/bin/bash
bin/recreate.sh
cd ..
grails clean
grails test-app
cd db
bin/dump.sh > schema-new.sql
bin/diff.sh schema.sql schema-new.sql > patch.diff
