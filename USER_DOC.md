
# User Documentation

## Overview

This project provides a containerized web infrastructure managed with Docker and Docker Compose.

The stack includes:
- A web server acting as the single entry point
- A WordPress website
- A MariaDB database

All services run inside dedicated Docker containers and communicate through a Docker network.

## Starting and Stopping the Project

### Start the Project

From the root of the repository, run the following command:

make

This command builds the Docker images and starts all required services.

### Stop the Project

To stop and remove the containers, run:

make down

## Accessing the Services

### Website

The website is accessible via a web browser at:

https://<login>.42.fr

The use of HTTPS is mandatory.  
Accessing the website using HTTP should fail.

To confirm that HTTP access is not allowed, run:

curl http://<login>.42.fr

### WordPress Administration Panel

The WordPress administration panel can be accessed at:

https://<login>.42.fr/wp-admin

Administrator credentials are required to log in.

## Credentials Management

Sensitive information such as database passwords and credentials is not hardcoded in the source files.

Credentials are managed using environment variables and Docker secrets.

These files are stored locally and must not be committed to the Git repository.

## Checking Services Status

To verify that all services are running correctly, use:

docker ps

All containers should be in a running state.

To inspect logs for a specific service, run:

docker compose logs <service_name>

Logs should not contain critical errors.

## to check the database mariadb and found the certificat:
docker exec -it nginx bash

## to go inside mariadb
/# mysql -uroot -p

## to see the different database:
SHOW DATABASES;
