#!/bin/bash
FILE=/opt/fw/data/matrixx.csv
cat ${FILE} | awk -F ';' ' NR>1  { print $4; }'| tr ',' '\n' | while read host
do 
# host should not be empty space or zero
if [ -n "$host" ] && [ "$host" != "0" ]; then 
#    echo "Host=>${host}<-------------------------------"
    cat ${FILE} | awk -F ';' -v h="${host}" ' NR > 1 && $4 ~ h { print h, $0;}' 
fi
done
