#!/bin/bash
FILE=/opt/fw/data/matrics1.csv
OUT=/opt/fw/data/host2.yml
echo 'all:' > ${OUT}
echo '  hosts:' >> ${OUT}

cat ${FILE} | awk -F ';' ' NR>1  { print $4; }'| tr ',' '\n' | sort -u | while read host
do 
# host should not be empty space or zero
if [ -n "$host" ] && [ "$host" != "0" ]; then
     echo "INFO: Host=>${host}<-------------------------------" 
     echo "    $host:" >> ${OUT}
     echo "      fw:" >> ${OUT}
     cat ${FILE} | awk -F ";" -v h="${host}" 'NR>1 && $4 ~ h { split($3,orgs,","); split($5,dests,","); split($7,ports,","); for(org in orgs){for(dest in dests){for(port in ports) {printf("        - { id: \"%s\", org_ip: \"%s\", dest_ip: \"%s\", port: \"%s\" }\n",$1, orgs[org], dests[dest], ports[port]); }}}}' >> ${OUT}
fi
done

 