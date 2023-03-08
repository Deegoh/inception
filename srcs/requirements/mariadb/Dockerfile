FROM alpine:3.16

RUN apk update
RUN apk add bash vim
RUN apk add mariadb mariadb-client

#mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
#cd '/usr' ; /usr/bin/mariadbd-safe --datadir='/var/lib/mysql'

RUN #apk add openrc --no-cache

RUN #mkdir "/etc/init.d/mariadb/"

EXPOSE 3306

#CMD ["sleep infinity"]

# vim my.cnf.d/mariadb-server.cnf