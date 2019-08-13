#!/bin/bash
mydir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")


#!/bin/bash
if test "$#" -ne 2; then
    echo "Illegal number of parameters"

else
cat "$2" |dos2unix | cut -d , -f 1,3,4 > "$mydir/a1.csv"
cat "$1" |dos2unix | cut -d , -f 3,4 > "$mydir/a2.csv"

paste -d , "$mydir/a1.csv" "$mydir/a2.csv"
fi