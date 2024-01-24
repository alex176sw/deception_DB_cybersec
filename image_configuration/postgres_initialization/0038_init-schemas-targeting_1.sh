#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS target_p;
	CREATE SCHEMA IF NOT EXISTS target_hvt;

EOSQL

