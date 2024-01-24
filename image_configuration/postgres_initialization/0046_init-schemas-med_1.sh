#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname med_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS med_w;
	CREATE SCHEMA IF NOT EXISTS med_lt;

EOSQL

