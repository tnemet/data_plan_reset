#!/bin/bash

limit=4

used=$(vnstat --oneline | cut -d ';' -f 11)
used_int=$(expr "$used" : '\([0-9]*\)')

echo "limit: $limit"
echo "iskoristeno: $used"

if [ $used_int -ge $limit ]
then   
echo "limit dosegnut!"
fi
