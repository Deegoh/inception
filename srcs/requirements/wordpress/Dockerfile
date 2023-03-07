FROM alpine:3.16
RUN apk update
RUN apk add bash vim curl
RUN apk add php8 php8-fpm php8-phar php8-curl
RUN #apk add php8-mysqli
RUN apk mysql mysql-client
RUN #apk mariadb mariadb-client
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN mkdir wp
RUN wp core download --locale=fr_FR --path=wp
RUN wp config create --dbname=${WORDPRESS_DB_NAME} --dbuser=${WORDPRESS_DB_USER} --dbpass=${WORDPRESS_DB_PASSWORD} --dbhost=${WORDPRESS_DB_HOST=} --locale=fr_FR --path=wp --config-file=wp/wp-config.php
RUN #wp core install --path=wp --url --title --admin_user --admin_email
EXPOSE 9000

#CMD ["sleep infinity"]
