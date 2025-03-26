FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget apt-transport-https gnupg curl sudo perl net-tools iproute2 squid && \
    wget http://www.webmin.com/jcameron-key.asc && \
    apt-key add jcameron-key.asc && \
    echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list && \
    apt-get update && \
    apt-get install -y webmin && \
    echo "root:P@ssw0rd" | chpasswd && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 10000 3128

CMD service webmin start && tail -f /dev/null && squid -N -d 1