#!/bin/bash

# Set the container name or ID of the PostgreSQL Docker container
POSTGRES_CONTAINER="postgres"

# Check if the container is running
if docker ps -q -f name=$POSTGRES_CONTAINER > /dev/null
then
    echo "Stopping PostgreSQL container: $POSTGRES_CONTAINER"
    docker stop $POSTGRES_CONTAINER
    echo "PostgreSQL container stopped successfully."
else
    echo "No running container found with the name or ID: $POSTGRES_CONTAINER"
fi
