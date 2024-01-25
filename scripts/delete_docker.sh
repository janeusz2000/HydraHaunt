#!/bin/bash

# Name of the PostgreSQL container you want to delete
CONTAINER_NAME="postgres"

# Stop the container
docker stop "$CONTAINER_NAME"

# Remove the container
docker rm "$CONTAINER_NAME"
