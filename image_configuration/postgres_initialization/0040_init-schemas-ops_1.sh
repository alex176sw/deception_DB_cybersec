#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname ops_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS ops_og;
	CREATE SCHEMA IF NOT EXISTS ops_f;

EOSQL

