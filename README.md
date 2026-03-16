This project has been created as part of the 42 curriculum by mhamidi.

# Inception

## Description

Inception is a system administration project whose goal is to discover and understand
Docker and Docker Compose through the creation of a complete containerized infrastructure.

The project focuses on setting up multiple services, each running in its own dedicated
Docker container, while respecting strict rules regarding security, isolation, networking,
and data persistence.

## Project Description

This project uses Docker to deploy a small infrastructure composed of several services.
Each service is built from a custom Dockerfile and runs inside its own container.

Docker Compose is used to orchestrate the containers, define their relationships, and
manage the Docker network and volumes.

The main design choices aim to ensure:
- Clear separation of services
- Secure handling of configuration and secrets
- Persistent data storage
- Controlled network communication between containers

### Virtual Machines vs Docker

Virtual Machines emulate a full operating system, including its own kernel, which makes
them heavier and slower to start.

Docker containers share the host system kernel and isolate only what is necessary.
This makes them lightweight, faster to deploy, and well suited for service-based
architectures like the one implemented in this project.

### Secrets vs Environment Variables

Environment variables are used to configure the application without hardcoding values
inside Dockerfiles.

Secrets are intended for sensitive data such as passwords and credentials. This approach
reduces the risk of leaking confidential information through version control and improves
overall security.

### Docker Network vs Host Network

A Docker network is used to allow containers to communicate with each other in an isolated
and controlled environment.

Using the host network is avoided in order to preserve container isolation, improve
security, and clearly define exposed services.

### Docker Volumes vs Bind Mounts

Docker volumes are managed directly by Docker and provide reliable and portable persistent
storage.

Bind mounts directly map host directories into containers, which can lead to permission
issues and reduced portability. For these reasons, Docker volumes are preferred in this
project.

## Instructions

### Requirements

- Linux virtual machine
- Docker
- Docker Compose
- Make

### Installation and Execution

1. Clone the repository:
   ```bash
   git clone <repository_url>
