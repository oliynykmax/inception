#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    chown -R mysql:mysql /var/lib/mysql

    mariadb-install-db --user=mysql --ldata=/var/lib/mysql > /dev/null

    echo "Starting MariaDB server for initial setup..."

    /usr/bin/mariadbd --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF

    echo "MariaDB initial setup completed."
else
    echo "MariaDB data directory already initialized."
fi

echo "Starting MariaDB server..."
exec /usr/bin/mysqld --user=mysql --console
