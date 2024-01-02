#!/bin/bash

docker run \
    --name pgadmin-container \
    -p 5050:80 \
    -e PGADMIN_DEFAULT_EMAIL=user@domain.com \
    -e PGADMIN_DEFAULT_PASSWORD=llama2iscool \
    -d dpage/pgadmin4