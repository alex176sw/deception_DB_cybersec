#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname w_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS commercial;
	CREATE SCHEMA IF NOT EXISTS taxes;

EOSQL

