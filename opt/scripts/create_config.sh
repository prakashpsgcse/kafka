#!/bin/bash

echo "In create_config.sh file "
echo "This file will contains scripts to create zoo.cfg file "

#//////////////////////////////from create_brokerid.sh

brokerID=${BROKER_ID:-0}


#If no Broker ID then if its k8s get oridial and have broker id start and end
# Calculate broker id from ORIDIAL + START
# OR USE ZK LOCK to generate broker ID from START

echo "broker id for this node ${brokerID}"
export brokerID=$brokerID

export hostIp=`hostname -I | cut -d' ' -f1`

echo " IP of the machine is ${hostIp}"

#//////////////////////////////from create_brokerid.sh
#Lets Assume whatever starts with KAFKA we have to replace them with properties
#Ex KAFKA_CONTROLLED_SHUTDOWN_ENABLE will be converted into controlled.shutdown.enable


mkdir -p /etc/kafka/conf
echo "broker.id=${brokerID}" > /etc/kafka/conf/server.properties


logDir=${DATA_DIR:-/data/kafka}
echo "log.dir=${logDir}" >> /etc/kafka/conf/server.properties

port=${PORT:-9092}
echo "advertised.port=${port}" >> /etc/kafka/conf/server.properties

echo "advertised.host.name=${hostIp}" >> /etc/kafka/conf/server.properties

echo "host.name=${hostIp}" >> /etc/kafka/conf/server.properties

echo "advertised.listeners=PLAINTEXT://${hostIp}:${port}" >> /etc/kafka/conf/server.properties

zookeeper=${ZOOKEEPER:-localhost:2181}
echo "zookeeper.connect=${zookeeper}" >> /etc/kafka/conf/server.properties



#
#mkdir -p /etc/zookeeper/conf
#
#
#clientPort=${CLIENT_PORT:-2181}
#echo "clientPort=${clientPort}" > /etc/zookeeper/conf/zoo.cfg
#
#serverPort=${SERVER_PORT:-2888}
#echo "serverPort=${serverPort}"
#
#electionPort=${ELECTION_PORT:-3888}
#echo "electionPort=${electionPort}"
#
#tickTime=${TICK_TIME:-2000}
#echo "tickTime=${tickTime}" >> /etc/zookeeper/conf/zoo.cfg
#
#initLimit=${INIT_LIMIT:-10}
#echo "initLimit=${initLimit}" >> /etc/zookeeper/conf/zoo.cfg
#
#syncLimit=${SYNC_LIMIT:-10}
#echo "syncLimit=${syncLimit}" >> /etc/zookeeper/conf/zoo.cfg
#
#dataDir=${DATA_DIR:-/mnt/zookeeper/data}
#echo "dataDir=${dataDir}" >> /etc/zookeeper/conf/zoo.cfg
#
#dataLogDir=${DATA_LOG_DIR:-/mnt/zookeeper/log}
#echo "dataLogDir=${dataLogDir}" >> /etc/zookeeper/conf/zoo.cfg
#
#
#
## 1. How to check its standalone or cluster deployment ?
## 2. For kubernetes how do you pass SERVER_ID (others will pass in env )? (because config has to be same)
## 3. How do you identity cluster size ?
## 4. How do you get all ips for the servers ?
## 5. How do to scale up/down in k8s ?
#
## For #1 we can use CLUSTER_SIZE for standalone we can use  1
## For #2 we can use ordinal (split hostname(zk-0) and get the ordinal from hostname at last + 1)
## For #3 use sol for #1 CLUSTER_SIZE
## for #4 get the list of servers .for k8s also get it
#
##For k8s should  we create myid always or only the first time or if myid not exits
#
#
#clusterSize="${CLUSTER_SIZE:-1}"
#
#if [ $clusterSize != 1 ]
#then
#      echo "Constructing zoo.cfg for cluster deployment"
#
#      echo "Finding/Generating myid"
#      if [[ -z "${SERVER_ID}" ]]; then
#              echo "server id is not provided .Assuming its k8s deployment"
#              [[ `hostname` =~ -([0-9]+)$ ]] || exit 1
#              ordinal=${BASH_REMATCH[1]}
#              myid=$((1 + $ordinal))
#        else
#               echo "server id provided"
#              myid=${SERVER_ID}
#      fi
#
#      echo ${myid} > ${dataDir}/myid
#      # Format for specifying zk's in current ensmble 1:ip:port:port 10:3888:2888,11:3888:2888
#      zookeeper_servers=${ZOOKEEPER_SERVERS}
#      echo "received zk servers = ${zookeeper_servers}"
#
#      IFS="," read -a servers <<< ${zookeeper_servers}
#      for server in "${servers[@]}"
#      do
#        echo "$server"
#        IFS=":" read -a data <<< $server
#        echo "server.${data[0]}=${data[1]}:${data[2]}:${data[3]}" >> /etc/zookeeper/conf/zoo.cfg
#      done
#
#fi
#
#
#
#
#
#
#echo "CREATED ALL CONFIGS "
#
#cat /etc/zookeeper/conf/zoo.cfg