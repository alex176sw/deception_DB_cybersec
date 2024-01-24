#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname move_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS move_w;
	CREATE SCHEMA IF NOT EXISTS move_lt;

EOSQL

