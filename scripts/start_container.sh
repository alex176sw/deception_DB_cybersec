#!/bin/bash

# The default postgres user and database are created in the entrypoint with initdb.
# A default pg_hba.conf file is installed when the data directory is initialized by initdb.
sudo rm -r mount
docker container stop deception-db 
docker container prune 

PGDATA_ROOT=/var/lib/postgresql/data

docker run -d \
    --name deception-db \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=password \
    -e PGDATA=${PGDATA_ROOT}/pg_data \
    -v $(pwd)/mount:${PGDATA_ROOT} \
    -v "$(pwd)/image_configuration/postgres_configurations/postgres.conf":/home/postgres/postgres_conf/postgres.conf \
    -v "$(pwd)/image_configuration/postgres_configurations/pg_hba.conf":/home/postgres/postgres_conf/pg_hba.conf \
    deception-db:latest \
    -c "config_file=/home/postgres/postgres_conf/postgres.conf" \
    -c "hba_file=/home/postgres/postgres_conf/pg_hba.conf"

    #-v "$(pwd)/image_configuration/postgres_initialization":/home/postgres/postgres_initialization \
    #-v $(pwd)/configurations/postgres.conf:/etc/postgresql/postgresql.conf \
    #-v $(pwd)/configurations/pg_hba.conf:/etc/postgresql/pg_hba.conf \
    #-v $(pwd)/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d \
    #-c "ident_file"
