#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname storage_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS storage_w;
	CREATE SCHEMA IF NOT EXISTS storage_lt;

EOSQL

