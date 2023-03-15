#!/bin/sh

while ! mysqladmin ping -h ${WORDPRESS_DB_HOST} --silent; do
  sleep 1
  echo "waiting for process mariadbd-safe"
done

echo "run wp"
if [ ! -e /var/www/html/wp-config.php ]; then
  echo "wp install"
  wp core download --path=/var/www/html --locale=fr_FR
  wp config create --path=/var/www/html --config-file=var/www/html/wp-config.php --dbname=${WORDPRESS_DB_NAME} --dbuser=${WORDPRESS_DB_USER} --dbpass=${WORDPRESS_DB_PASSWORD} --dbhost=${WORDPRESS_DB_HOST} --locale=fr_FR
  wp core install --path=/var/www/html --url=${WORDPRESS_URL} --title="${WORDPRESS_TITLE}" --admin_user=${WORDPRESS_ADM_USER} --admin_password=${WORDPRESS_ADM_PASSWORD} --admin_email="${WORDPRESS_ADM_USER}@${WORDPRESS_URL}.ch"

  echo "create user"
  wp user create ${WORDPRESS_USER} ${WORDPRESS_USER}@${WORDPRESS_URL}.com --user_pass=${WORDPRESS_PASSWORD} --path=/var/www/html
else
  echo "wp already install"
fi

echo "run php-fpm"
php-fpm8 -F
