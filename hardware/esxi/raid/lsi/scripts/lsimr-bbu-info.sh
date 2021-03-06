#!/bin/bash

# Collecting data from LSI MegaRAID controller
# Andrey Kuznetsov, 2022.02.20

# Get variables
HVUID=$1
CTLID=$2
HOST=$(grep -w $HVUID /usr/lib/zabbix/internalscripts/hardware/esxi/hosts-uid-map.txt | awk '{print $NF}')

# Get controller id
# If the controller id is not passed, we display all the information
    if [[ $CTLID = "" ]]; then
       echo "ssh -i /usr/lib/zabbix/.ssh/id_rsa zabbix@$HOST 'cd /opt/lsi/storcli && ./storcli show all j'" | bash
    else
# Integer test value of a variable
    re='^[0-9]+$'
    if ! [[ $CTLID =~ $re ]] ; then
       echo "error: Not a number" >&2; exit 1
    else
# We form the data of the received controller
        CTLSTR="ssh -i /usr/lib/zabbix/.ssh/id_rsa zabbix@$HOST 'cd /opt/lsi/storcli && ./storcli /c$CTLID/bbu show all j'"
        echo $CTLSTR | bash
    fi
fi
