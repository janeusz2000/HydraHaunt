#!/bin/bash

# Run the Docker image and output the result to a file
docker run --name postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
