#!/bin/sh

echo "memory_limit = 512M" >> /etc/php84/php.ini

cd /var/www/html

echo "Waiting for MariaDB to be ready..."
until mariadb-admin ping -h mariadb -u root -p"$MYSQL_ROOT_PASSWORD" --silent; do
    echo "MariaDB is not ready yet, waiting..."
    sleep 2
done
echo "MariaDB is ready!"

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost=mariadb \
    --allow-root \
    --force

wp core install \
    --url="$DOMAIN_NAME" \
    --title="Inception" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email \
    --allow-root \
    --path=/var/www/html

wp user create \
    "$WP_USER" "$WP_EMAIL" \
    --user_pass="$WP_PASSWORD" \
    --role=author \
    --allow-root

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

exec /usr/sbin/php-fpm84 -F
