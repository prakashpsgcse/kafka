FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y curl wget runit default-jre-headless psmisc dnsutils iproute2\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


ENV KAFKA_VERSION=2.7.0 \
    SCALA_VERSION=2.13 \
    KAFKA_DATA_DIR=/data/zookeeper/data \
    KAFKA_CONF=/etc/zookeeper/conf


RUN wget -q https://archive.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz && tar -xzf kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz -C /opt
RUN mv /opt/kafka_$SCALA_VERSION-$KAFKA_VERSION /opt/kafka

COPY etc/ /etc
COPY opt/scripts /opt/scripts
RUN chmod -R 777 /etc
RUN chmod -R 777 /opt/scripts

VOLUME ["/data/kafka/data"]

EXPOSE 9092

STOPSIGNAL SIGCONT
CMD ["/sbin/runit-init"]