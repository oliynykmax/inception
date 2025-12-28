#!/bin/sh

# Wait for MariaDB to be ready
while ! mariadb -h mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Check if wp-config.php already exists
if [ ! -f "/var/www/html/wp-config.php" ]; then
    # Download wp-cli
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Create wp-config.php
    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/html'

    # Install WordPress
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception"
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    # Create a second user
    wp user create --allow-root \
        $WP_USER $WP_EMAIL \
        --role=author \
        --user_pass=$WP_PASSWORD
fi

exec "$@"
