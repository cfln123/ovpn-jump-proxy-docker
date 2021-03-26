#!/bin/sh

mkdir -p /dev/net && \
mknod /dev/net/tun c 10 200 && \
chmod 600 -R /dev/net/tun /etc/openvpn/

/usr/sbin/sshd
/usr/bin/tinyproxy -c /etc/tinyproxy/tinyproxy.conf
cd /etc/openvpn/config/$OVPN_PATH && openvpn --config conf.ovpn