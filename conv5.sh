#!/bin/bash
FILE=/opt/fw/data/matrixx.csv
cat ${FILE} | awk -F ';' ' NR>1  { print $4; }'| tr ',' '\n' | while read host
do 
# host should not be empty space or zero
if [ -n "$host" ] && [ "$host" != "0" ]; then 
#    echo "Host=>${host}<-------------------------------"
    cat ${FILE} | awk -F ';' -v h="${host}" ' NR > 1 && $4 ~ h { print $0;}' >> /opt/fw/data/Temp_host_matrix.csv
fi
done
    cat /opt/fw/data/Temp_host_matrix.csv | awk -F ";" 'NR>1 {split($3,orgs,",")} END {for(org in orgs){ print orgs[org] }}' >> /opt/fw/data/Temp_orgs_matrix.csv
    cat /opt/fw/data/Temp_host_matrix.csv | awk -F ";" 'NR>1 {split($5,dests,",")} END {for(dest in dests){ print dests[dest] }}' >> /opt/fw/data/Temp_dests_matrix.csv
    cat /opt/fw/data/Temp_host_matrix.csv | awk -F ";" 'NR>1 {split($7,ports,",")} END {for(port in ports){ print ports[port] }}' >> /opt/fw/data/Temp_ports_matrix.csv
#  column 3 is orgs 198.18.101.98
#  column 5 is dests 10.78.162.225
#  column 7 is ports 8086
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
 