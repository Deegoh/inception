FROM alpine:3.16

RUN apk update
RUN apk add bash vim
RUN apk add mariadb mariadb-client

EXPOSE 3306

COPY conf/db-entrypoint.sh /
RUN chmod +x /db-entrypoint.sh

ENTRYPOINT ["/bin/sh", "/db-entrypoint.sh"]
