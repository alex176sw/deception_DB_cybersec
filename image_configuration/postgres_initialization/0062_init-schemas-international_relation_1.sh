#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname international_relation_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS international_relation_n;
	CREATE SCHEMA IF NOT EXISTS international_relation;

EOSQL

