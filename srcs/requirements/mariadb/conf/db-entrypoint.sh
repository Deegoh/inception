#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
  echo "install mariadb"

  echo "setup folder rights"
  mkdir -p /auth_pam_tool_dir
  mkdir -p /auth_pam_tool_dir/auth_pam_tool
  chown -R mysql /auth_pam_tool_dir
  chgrp -R mysql /auth_pam_tool_dir

  mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

  echo "Run on background mariadb"
  mariadbd-safe --nowatch --datadir='/var/lib/mysql'

  while ! mysqladmin ping -h ${MARIADB_HOST} --silent; do
    sleep 1
    echo "waiting for process mariadbd-safe"
  done

  #secure mariadb
  echo "Secure mariadb"
  #remove anonymous accounts
  mariadb -e "DELETE FROM mysql.user WHERE User='';"
  #remove test database
  mariadb -e "DROP DATABASE IF EXISTS test;"
  #remove root account accessible from outside
  mariadb -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

  #setup wp db
  echo "Setup database wordpress"
  mariadb -e "CREATE DATABASE ${MARIADB_DATABASE};"
  mariadb -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
  mariadb -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';"

  #change root pwd
  mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
  #apply config db
  mariadb -e "FLUSH PRIVILEGES;"

  sleep 1
  echo "restart mariadb"
  pkill maria

else
  echo "Already installed"
fi

echo "start mariadb"
mariadbd-safe --datadir='/var/lib/mysql'
