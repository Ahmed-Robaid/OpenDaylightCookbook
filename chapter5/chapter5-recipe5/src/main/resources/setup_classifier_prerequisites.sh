#!/bin/bash

apt-get update -y
apt-get install autoconf -y
apt-get install libtool -y
apt-get install git -y
apt-get install python3-flask requests netifaces -y
apt-get install libssl-dev openssl -y
apt-get install libnetfilter-queue-dev -y
apt-get install python3-pip -y
pip3 install sfc
apt-get install git curl -y
apt-get install mini-httpd -y