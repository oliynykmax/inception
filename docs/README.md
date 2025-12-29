# *This project has been created as part of 42 curriculum by maoliiny*

## Description

Inception is a system administration project that demonstrates Docker and Docker Compose skills by setting up a small infrastructure composed of multiple services. The project involves virtualizing different Docker images to create a fully functional WordPress website with NGINX, PHP-FPM, and MariaDB, all running in separate containers and connected via a custom Docker network.

The main goals are to:
- Understand Docker containerization and orchestration
- Learn system administration best practices
- Implement secure configurations with TLS certificates
- Manage persistent data using Docker volumes

## Instructions

### Prerequisites
- A VM
- Docker and Docker Compose installed

### Installation and Execution

1. Clone the repository:
```bash
git clone <repository-url>
cd inception
```

2. Configure environment variables:
```bash
cp srcs/.env.example srcs/.env
# Edit srcs/.env with your credentials and domain name
```

3. Build and start the project:
```bash
make
```

4. Access the website:
```bash
# Open your browser and navigate to:
https://maoliiny.42.fr
```

### Available Makefile Targets

- `make`: Build and start all services
- `make build`: Build Docker images
- `make up`: Start all containers
- `make down`: Stop all containers
- `make clean`: Stop containers and remove volumes
- `make fclean`: Full cleanup (containers, images, volumes)
- `make re`: Full rebuild and restart

## Resources

### Documentation
- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Beginner Guide](https://nginx.org/en/docs/beginners_guide.html)
- [WordPress Documentation](https://wordpress.org/documentation/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)

### AI usage
- Opencode was a great helper when writing markdown files as well as trouble shooting the problems of talkibg between containers.

## Project Description

### Virtual Machines vs Docker

**Virtual Machines:**
- Run complete operating systems with their own kernel
- Require more system resources 
- Slower startup times 
- Heavyweight isolation

**Docker:**
- Share host OS kernel
- Lightweight, use fewer resources
- Faster startup times 
- Process-level isolation
- More efficient for running multiple services

### Secrets vs Environment Variables

**Secrets:**
- Designed for sensitive data (passwords, API keys)
- Managed by Docker with encryption at rest
- More secure for production environments
- Can be rotated without container rebuild
- Access controlled via Docker Swarm/Kubernetes

**Environment Variables:**
- Simpler configuration method
- Visible in container inspection
- Suitable for non-sensitive configuration
- Easier for development and testing

### Docker Network vs Host Network

**Docker Network:**
- Isolated network for containers
- Better security and separation
- Service discovery by container name
- Prevents port conflicts

**Host Network:**
- Containers share host's network stack
- Direct host port binding
- Less secure (no isolation)
- Potential naming conflicts

### Docker Volumes vs Bind Mounts

**Docker Volumes:**
- Managed by Docker
- Cross-platform compatible
- Easier to backup and migrate
- Better performance on Linux
- Independent of host file structure
- Abstracted storage location

**Bind Mounts:**
- Direct mapping to host directory
- Simple to understand and use
- Real-time file changes visible
- Host-dependent paths
- Less portable between systems
- Direct control over file locations
