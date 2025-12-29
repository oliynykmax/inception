# User Documentation - Inception

This guide explains how to use and manage the Inception infrastructure as an end user or administrator.

## Services Provided by the Stack

The Inception project provides the following services:

- **NGINX**: Web server with SSL/TLS encryption
- **WordPress + PHP-FPM**: Content management system
- **MariaDB**: Database server for WordPress

All services run in isolated containers and communicate through a private Docker network.

## Starting and Stopping the Project

### Start all services:
```bash
make
```
Or use the explicit target:
```bash
make up
```

### Stop all services:
```bash
make down
```

### Full cleanup (including data):
```bash
make fclean
```

## Accessing the Website and Administration Panel

### Access the Website:
Open your browser and navigate to:
```
https://maoliiny.42.fr
```

**Important:**
- You may see a browser warning for the self-signed SSL certificate - this is normal

### Access the WordPress Admin Panel:

1. Go to: `https://maoliiny.42.fr/wp-admin`
2. Enter your administrator credentials:
   - Username: `maoliiny` (or your configured admin user)
   - Password: `a_very_secure_admin_password_789` (or your configured password)

## Managing Credentials

All credentials are stored in the `.env` file located in the `srcs/` folder.

### Default Configuration:

The `.env` file contains:
- `DOMAIN_NAME`: Your domain (e.g., maoliiny.42.fr)
- `MYSQL_DATABASE`: WordPress database name
- `MYSQL_USER`: Database user
- `MYSQL_PASSWORD`: Database password
- `MYSQL_ROOT_PASSWORD`: MariaDB root password
- `WP_ADMIN_USER`: WordPress admin username
- `WP_ADMIN_PASSWORD`: WordPress admin password
- `WP_ADMIN_EMAIL`: Admin email address
- `WP_USER`: Additional WordPress user
- `WP_PASSWORD`: Additional user password
- `WP_EMAIL`: Additional user email

## Checking Service Status

### Check if all containers are running:
```bash
docker compose ps
```

Expected output should show:
- `mariadb`: Status `Up (healthy)`
- `wordpress`: Status `Up`
- `nginx`: Status `Up`

### View container logs:
```bash
docker compose logs <service-name>
```
### Check Docker network:
```bash
docker network ls | grep inception
```

### Check Docker volumes:
```bash
docker volume ls | grep inception
```
