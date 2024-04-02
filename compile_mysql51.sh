#!/bin/bash
set -euo pipefail

# script to compile mysql51 for docker
VERSION=${1:-5.1.51}
SOURCE=mysql-${VERSION}.tar.gz
URL=https://downloads.mysql.com/archives/get/p/23/file/$SOURCE

if [ "${VERSION:0:4}" != "5.1." ]; then
    echo "Version is not 5.1"
    exit 1
fi

#make data dir
mkdir -p /db /usr/local/src

#make and install mysql51
cd /usr/local/src/
if [ ! -r $SOURCE ]; then
    wget $URL
fi

tar -xvzf mysql-${VERSION}.tar.gz
cd mysql-${VERSION}/ || exit 1
./configure --prefix=/usr/local/mysql --localstatedir=/db --with-mysqld-user=mysql CXXFLAGS="-std=gnu++98"
make && make install
cp support-files/my-medium.cnf /etc/my.cnf
make clean

#adopt rights
cd /usr/local/mysql/
chown -R root:mysql .
chown -R mysql:mysql /db


