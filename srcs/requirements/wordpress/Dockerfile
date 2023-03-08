FROM alpine:3.16

RUN apk update
RUN apk add bash vim curl
RUN apk add php8 php8-fpm php8-phar php8-curl php8-mysqli php8-iconv
RUN apk add mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/wp-entrypoint.sh /
RUN chmod +x /wp-entrypoint.sh
COPY conf/www.conf /etc/php8/php-fpm.d/www.conf

ENTRYPOINT ["/bin/sh", "/wp-entrypoint.sh"]

EXPOSE 9000
