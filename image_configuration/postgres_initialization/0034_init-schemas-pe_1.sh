#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname pe_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS personnel;
	CREATE SCHEMA IF NOT EXISTS employees;

EOSQL

