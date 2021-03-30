#!/bin/bash

echo "In create_config.sh file. Write all storage related scripts here  "
echo " Change this file for mounting disk to zookeeper "

# mount volume here if you are using external storage

if [ -z "$DATA_DIR" ]; then
   echo "Not provided location for data dir .using default /mnt/zookeeper/data "
   mkdir -p /mnt/zookeeper/data
fi

