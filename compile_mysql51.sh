#!/bin/bash

set -euo pipefail
# script to compile mysql51 for docker

#make data dir
mkdir -p /db /usr/local/src

#make and install mysql51
cd /usr/local/src/
tar -xvzf /root/mysql-5.1.51.tar.gz
cd mysql-5.1.51/
./configure --prefix=/usr/local/mysql --localstatedir=/db --with-mysqld-user=mysql CXXFLAGS="-std=gnu++98"
make && make install
cp support-files/my-medium.cnf /etc/my.cnf
make clean

#adopt rights
cd /usr/local/mysql/
chown -R root:mysql .
chown -R mysql:mysql /db


