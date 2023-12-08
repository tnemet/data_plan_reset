#!/bin/bash

#set limit in GB
limit=5
#check usage, RX only. 4th field of vnstat output
#vnstat saveInterval is in minutes so it should be worked around to work in seconds 
#(deamon.c void adjustsaveinterval(DSTATE *s))
used=$(vnstat --oneline | cut -d ';' -f 4)
used_int=$(awk -v used="$used" 'BEGIN { printf "%.0f", used }')

echo "rounded: $used_int" 
echo "limit: $limit"
echo "used: $used"

if [ $used_int -ge $limit ]
then   
echo "limit dosegnut!"
fi
