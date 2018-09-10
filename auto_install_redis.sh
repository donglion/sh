#!/bin/sh
#author dhs 2018-9-10 23:10:40
cd /opt
yum install -y gcc wget
wget http://download.redis.io/releases/redis-$1.tar.gz
wget https://github.com/donglion/sh/blob/master/redisd
tar xzf redis-$1.tar.gz
cd redis-$1
make && make install
cd /etc
mkdir redis
cp /opt/redis-$1/redis.conf /etc/redis/6379.conf
sed -i "s/daemonize no/daemonize yes/g" /etc/redis/6379.conf
cp /opt/redisd /etc/init.d/
chmod 744 /etc/init.d/redisd
chkconfig redisd on
service redisd start
