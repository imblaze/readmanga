#!/bin/bash
diff  -y --left-column $1 $2
exit $?
