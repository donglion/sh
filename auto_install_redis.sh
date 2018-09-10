#!/bin/sh
#author dhs 2018.5.19
yum install -y gcc wget
wget http://download.redis.io/releases/redis-3.2.4.tar.gz
tar xzf redis-3.2.4.tar.gz
cd redis-3.2.4
make && make install
cd /etc
mkdir redis
cp /opt/redis-3.2.4/redis.conf /etc/redis/6379.conf
sed -i "s/daemonize no/daemonize yes/g" /etc/redis/6379.conf
cd /etc/init.d
touch redisd
echo '#!/bin/sh' >> redisd
echo '# chkconfig: 2345 90 10' >> redisd
echo '# description: Redis is a persistent key-value database' >> redisd
echo '# Simple Redis init.d script conceived to work on Linux systems' >> redisd
echo '# as it does use of the /proc filesystem.' >> redisd
echo '' >> redisd
echo 'REDISPORT=6379' >> redisd
echo 'EXEC=/usr/local/bin/redis-server' >> redisd
echo 'CLIEXEC=/usr/local/bin/redis-cli' >> redisd
echo '' >> redisd
echo 'PIDFILE=/var/run/redis_${REDISPORT}.pid' >> redisd
echo 'CONF="/etc/redis/${REDISPORT}.conf"' >> redisd
echo '' >> redisd
echo 'case "$1" in' >> redisd
echo '    start)' >> redisd
echo '        if [ -f $PIDFILE ]' >> redisd
echo '        then' >> redisd
echo '                echo "$PIDFILE exists, process is already running or crashed"' >> redisd
echo '        else' >> redisd
echo '                echo "Starting Redis server..."' >> redisd
echo '                $EXEC $CONF' >> redisd
echo '        fi' >> redisd
echo '        ;;' >> redisd
echo '    stop)' >> redisd
echo '        if [ ! -f $PIDFILE ]' >> redisd
echo '        then' >> redisd
echo '                echo "$PIDFILE does not exist, process is not running"' >> redisd
echo '        else' >> redisd
echo '                PID=$(cat $PIDFILE)' >> redisd
echo '                echo "Stopping ..."' >> redisd
echo '                $CLIEXEC -a "password" -p $REDISPORT shutdown' >> redisd
echo '                while [ -x /proc/${PID} ]' >> redisd
echo '                do' >> redisd
echo '                    echo "Waiting for Redis to shutdown ..."' >> redisd
echo '                    sleep 1' >> redisd
echo '                done' >> redisd
echo '                echo "Redis stopped"' >> redisd
echo '        fi' >> redisd
echo '        ;;' >> redisd
echo '    *)' >> redisd
echo '        echo "Please use start or stop as first argument"' >> redisd
echo '        ;;' >> redisd
echo 'esac' >> redisd
chmod 744 /etc/init.d/redisd
chkconfig redisd on
service redisd start
