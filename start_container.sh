#!/bin/bash



PGDATA_ROOT=/var/lib/postgresql/data

docker run -d \
    --name deception-db \
    -p 5433:5432 \
    -e POSTGRES_PASSWORD=password \
    -e PGDATA=${PGDATA_ROOT}/pg_data \
    -v $(pwd)/mount:${PGDATA_ROOT} \
    -v "$(pwd)/image_configuration/postgres_configurations/postgres.conf":/home/postgres/postgres_conf/postgres.conf \
    -v "$(pwd)/image_configuration/postgres_configurations/pg_hba.conf":/home/postgres/postgres_conf/pg_hba.conf \
    deception-db:latest \
    -c "config_file=/home/postgres/postgres_conf/postgres.conf" \
    -c "hba_file=/home/postgres/postgres_conf/pg_hba.conf"


