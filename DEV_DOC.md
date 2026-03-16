# Developer Documentation

## Overview

This document is intended for developers who want to understand, set up, build, and
maintain the project infrastructure.

The project relies on Docker and Docker Compose to deploy a multi-service environment
using custom-built images and persistent storage.

## Environment Setup

### Prerequisites

The following tools are required to work on this project:

- A Linux virtual machine
- Docker
- Docker Compose
- Make

### Project Structure

The project is organized as follows:

- A Makefile at the root of the repository
- A srcs directory containing all Docker-related configuration
- Custom Dockerfiles for each service
- Configuration files and scripts required for container initialization
- Docker volumes used for persistent data storage

## Build and Launch

### Build and Start the Infrastructure

From the root of the repository, run:

make

This command:
- Builds all Docker images using the custom Dockerfiles
- Creates the Docker network
- Creates and mounts Docker volumes
- Starts all containers using Docker Compose

### Stop and Clean the Infrastructure

To stop and remove the containers, run:

make down

This stops the services while preserving the Docker volumes unless explicitly removed.

## Managing Containers and Volumes

### Containers

To list running containers, use:

docker ps

To stop all running containers manually, use:

docker stop <container_name>

### Volumes

Project data is stored using Docker named volumes.

These volumes ensure data persistence across container restarts and are stored inside
the /home/<login>/data directory on the host machine, as required by the subject.

To list Docker volumes, use:

docker volume ls

## Data Persistence

Two Docker volumes are used:
- One volume for the WordPress database
- One volume for the WordPress website files

Using Docker volumes instead of bind mounts improves portability and reduces host
dependency issues.

## Debugging and Logs

To inspect logs for a specific service, use:

docker compose logs <service_name>

Logs can be used to diagnose startup issues, configuration errors, or runtime failures.

## Credentials and Configuration

Sensitive data such as passwords and credentials is not stored directly in Dockerfiles.

Configuration is handled using:
- Environment variables defined in a .env file
- Docker secrets for confidential information

This approach prevents sensitive data from being committed to version control.

## Notes for Maintenance

- Each service runs in its own dedicated container
- All images are built manually and do not rely on pre-built service images
- The infrastructure is accessible only through the NGINX container via HTTPS
- Containers are configured to restart automatically in case of failure
