#!/bin/bash

# 
# With concern about execution time for this script, considering options (what)TO-DO:
#   - make 2 scripts, one to check limit and other one to send SMS code if neccessary
#   - research for some kind of watchdog to monitor vnstat database for changes
# 5 hours later research done.
# Zabbix is the answer, so will try to configure zabbix agent for ths purpose

#set limit in GB
limit=5

# Modem device
DEV=/dev/ttyUSB0
# Destination mumber
DESTNUM="095200100"
# Message
SMS="NEOGRANICENO"

# check usage, RX only. 4th field of vnstat output
# vnstat saveInterval is in minutes so it should be worked around to work in seconds 
# (deamon.c void adjustsaveinterval(DSTATE *s))
used=$(vnstat --oneline | cut -d ';' -f 4)
used_int=$(awk -v used="$used" 'BEGIN { printf "%.0f", used }')

# echo values, for testing only
echo "limit: $limit"
echo "used: $used"
echo "rounded: $used_int" 

if [ $used_int -ge $limit ]
then   
# we need to put sleep 1 to slow down commands for modem to process
echo -e "ATZ\r" >$DEV
sleep 1
echo -e "AT+CMGF=1\r" >$DEV
sleep 1
echo -e "AT+CMGS=\"$DESTNUM\"\r" >$DEV
sleep 1
echo -e "$SMS\x1A" >$DEV
fi

 
