#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname ga_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS general;
	CREATE SCHEMA IF NOT EXISTS affairs;

EOSQL

