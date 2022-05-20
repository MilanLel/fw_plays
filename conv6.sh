#!/bin/bash
FILE=/opt/fw/data/matrixx.csv

cat ${FILE} | awk -F ';' ' NR>1  { print $4; }'| tr ',' '\n' | while read host
do 
# host should not be empty space or zero
if [ -n "$host" ] && [ "$host" != "0" ]; then
     echo "Host=>${host}<-------------------------------" 
#    create temp hosts file - corrected hosts -------------------------------"
#    cat ${FILE} | awk -F ';' -v h="${host}" ' NR > 1 && $4 ~ h { print h, $0;}' >> /opt/fw/data/Temp_hosts_matrix.csv
     cat ${FILE} | awk -F ";" -v h="${host}" 'NR>1 && $4 ~ h { split($3,orgs,","); split($5,dests,","); split($7,ports,","); for(org in orgs){for(dest in dests){for(port in ports) {print h, orgs[org], dests[dest], ports[port]; }}}}' >> /opt/fw/data/Temp_ports_matrix.csv
fi
done
#   create three nested loops 
#    cat /opt/fw/data/Temp_hosts_matrix.csv | awk -F ";" 'NR>1 { split($3,orgs,","); split($5,dests,","); split($7,ports,","); for(org in orgs){for(dest in dests){for(port in ports) {print orgs[org], dests[dest], ports[port]; }}}}' >> /opt/fw/data/Temp_ports_matrix.csv


 