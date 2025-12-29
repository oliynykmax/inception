# Developer Documentation - Inception

This guide explains how to set up, build, and manage the Inception project from a developer's perspective.

## Setting Up the Environment from Scratch

### Prerequisites

1. Install Docker on your VM:
```bash
# For Alpine/Debian-based systems
sudo apt-get update
sudo apt-get install docker.io docker-compose
sudo usermod -aG docker $USER
```

2. Clone the repository:
```bash
git clone <repository-url>
cd inception
```

3. Create environment configuration:
```bash
# Copy example file (or create manually)
cp srcs/.env.example srcs/.env

# Edit with your credentials
vim srcs/.env
```

### Key Configuration Points

1. **Domain Name**: Set `DOMAIN_NAME` in `.env` to your login (e.g., maoliiny.42.fr)
2. **SSL Certificate**: Generated automatically in NGINX Dockerfile for `login.42.fr`
3. **Volumes**: Data stored in `/home/login/data/` on the host machine
4. **Network**: Custom bridge network for inter-container communication

## Building and Launching with Makefile

### Build Docker Images:
```bash
make build
```

This command:
- Creates required data directories (`/home/login/data/mariadb`, `/home/login/data/wordpress`)
- Builds all Docker images using docker-compose
- Uses `FROM alpine:3.22` as base image

### Start All Services:
```bash
make up
```

This command:
- Starts all containers in detached mode
- Waits for MariaDB to be healthy before starting WordPress
- Creates Docker network and volumes

### Full Build and Start:
```bash
make
```

Combines `make build` and `make up` in one command.

## Managing Containers and Volumes

### Container Management Commands

#### List all containers:
```bash
docker compose ps
```

#### View logs for a service:
```bash
docker compose logs <service-name>
```

#### Stop containers:
```bash
make down
# or
docker compose down
```

#### Remove everything:
```bash
make fclean
# Removes containers, images, and volumes
```

### Volume Management Commands

#### List all volumes:
```bash
docker volume ls
```

#### Inspect a volume:
```bash
docker volume inspect srcs_mariadb_data
docker volume inspect srcs_wordpress_data
```

#### Remove specific volumes:
```bash
docker volume rm srcs_mariadb_data srcs_wordpress_data
```

### Network Management

#### View network configuration:
```bash
docker network inspect srcs_inception
```

## Data Persistence

### Where Data is Stored

All persistent data is stored in Docker volumes mapped to the host:

1. **WordPress Files**: `/home/login/data/wordpress`
   - WordPress core files
   - Themes and plugins
   - Media uploads
   - Mounted to: `/var/www/html` in wordpress container

2. **MariaDB Data**: `/home/login/data/mariadb`
   - Database tables
   - User data
   - Configuration
   - Mounted to: `/var/lib/mysql` in mariadb container

### How Persistence Works

1. **Initial Setup**:
   - Docker creates volumes defined in docker-compose.yml
   - Volumes map host directories to container paths
   - MariaDB initializes the database on the first run

2. **Container Restarts**:
   - Data persists in volumes
   - Containers restart with `restart: always` policy
   - No data loss on container restart

3. **VM Reboot**:
   - Docker daemon starts containers on boot
   - Volumes reconnect automatically
   - All data remains intact

### Database Login

To access MariaDB directly:
```bash
docker exec -it mariadb mariadb -u root -p
```

## Health Checks

### MariaDB Health Check:
```dockerfile
HEALTHCHECK --interval=5s --timeout=3s --retries=5 \
    CMD mariadb-admin ping --protocol=tcp --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD --silent || exit 1
```

This ensures:
- MariaDB is ready before WordPress starts
- WordPress waits via `depends_on: condition: service_healthy`
- No manual polling loops needed in scripts

### Execute commands in running containers:
```bash
# Access WordPress container
docker exec -it wordpress sh

# Access MariaDB container
docker exec -it mariadb sh

# Access NGINX container
docker exec -it nginx sh
```

### View real-time resource usage:
```bash
docker stats
```
