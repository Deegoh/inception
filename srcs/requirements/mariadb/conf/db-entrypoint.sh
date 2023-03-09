#!/bin/sh

echo "install mariadb"
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

echo "Run on background mariadb"
mariadbd-safe --nowatch --datadir='/var/lib/mysql'

sleep 10

echo "Secure mariadb"
#remove root account accessible from outside
#echo "rm outside"
#mariadb -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
#remove anonymous accounts
echo "rm anonymous"
mariadb -e "DELETE FROM mysql.user WHERE User='';"
#remove test database
echo "drop test"
mariadb -e "DROP DATABASE IF EXISTS test;"
#change root pwd

#setup wp sb
echo "Setup database wordpress"
echo "ads db"
mariadb -e "CREATE DATABASE ${MARIADB_DATABASE};"
echo "add usr"
mariadb -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
echo "grand priv"
mariadb -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';"

echo "add pwd"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"

echo "kill maria"
pkill mariadbd-safe

#setup wp sb
echo "reRun mariadb"
mariadbd-safe --datadir='/var/lib/mysql'
sleep infinity

SELECT user, host, password from mysql.user;