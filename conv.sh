#!/bin/bash
FILE=/opt/fw/data/matrixx.csv

# Treba da se ubaci regex da parsuje  da je $4 hostname , da nije broj , prazno  , space ... non-white charcter \W(.+
#) da nije digit \d(.+)

cat ${FILE} | awk -F ';' ' NR>1  { print $4; }'| tr ',' '\n' | while read host
do 
    echo "Host=>${host}<"

    cat ${FILE} | awk -F ';' -v host=${host}  ' NR>1 { print " Check Line =",$1, $3, $4, $6; }' 
     ###  split( $3, ',', orgs)
     ###  split( $3, ',', dests)
     ###  split( $3, ',', ports)
     ##   for ( org in orgs){
     ##       for ( dst in dsts ){
     ##         for ( port  in ports){
     ##             print "      ", $1, org, dest, port;
     ##         }
     ##     } 
     ## }

done