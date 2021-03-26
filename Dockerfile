FROM ubuntu:20.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt upgrade -y && \
    apt install -y openvpn openssh-server tinyproxy curl wget telnet iputils-ping vim git unzip 

RUN mkdir -p /etc/openvpn/
ADD ovpn-config/ /etc/openvpn/config/
RUN chmod 600 -R /etc/openvpn/config/*

ADD tinyproxy/tinyproxy.conf /etc/tinyproxy/

RUN mkdir /root/.ssh
ADD ssh_keys/authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
RUN mkdir /var/run/sshd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 8888/tcp
EXPOSE 22/tcp

ENTRYPOINT [ "/entrypoint.sh" ]
