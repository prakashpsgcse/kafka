#!/bin/bash

echo "In create_brokerid.sh file "
echo "Write a logic to create broker id here "

brokerID=${BROKER_ID:-0}


#If no Broker ID then if its k8s get oridial and have broker id start and end
# Calculate broker id from ORIDIAL + START
# OR USE ZK LOCK to generate broker ID from START

echo "broker id for this node ${brokerID}"
export brokerID=$brokerID

export hostIp=`hostname -I | cut -d' ' -f1`

echo " IP of the machine is ${hostIp}"