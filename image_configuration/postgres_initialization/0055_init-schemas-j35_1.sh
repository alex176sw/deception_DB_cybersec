#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname j35_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS j35_p;

EOSQL

