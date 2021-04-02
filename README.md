# kafka
kafka docker image 

```shell
docker run --net host -d -e BROKER_ID=100 -e PORT=9092 kafka
docker run --net host -d -e BROKER_ID=101 -e PORT=9093 kafka
docker run --net host -d -e BROKER_ID=102 -e PORT=9094 kafka
```
