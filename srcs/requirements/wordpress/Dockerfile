FROM alpine:3.16
RUN apk update
RUN apk add bash vim curl
RUN apk add php8 php8-fpm php8-phar php8-curl
RUN #apk add php8-mysqli
RUN #apk mysql mysql-client
RUN apk add mariadb mariadb-client
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN #mkdir /var/www/html
#RUN chmod -R 777 /var/www/html
#RUN wp core download --path=var/www/html --locale=fr_FR
#RUN wp config create --path=var/www/html --config-file=var/www/html/wp-config.php --dbname=${WORDPRESS_DB_NAME} --dbuser=${WORDPRESS_DB_USER} --dbpass=${WORDPRESS_DB_PASSWORD} --dbhost=${WORDPRESS_DB_HOST} --locale=fr_FR
#RUN wp db create --path=var/www/html
#RUN wp core install --path=var/www/html --url=${WORDPRESS_URL} --title=${WORDPRESS_TITLE} --admin_user=${WORDPRESS_ADM_USER} --admin_password=${WORDPRESS_ADM_PASSWORD} --admin_email="123@123.com"
EXPOSE 9000

#CMD ["sleep infinity"]
