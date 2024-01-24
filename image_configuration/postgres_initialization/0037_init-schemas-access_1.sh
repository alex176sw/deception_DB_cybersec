#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname access_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS access_garrison;
	CREATE SCHEMA IF NOT EXISTS access_closed;

EOSQL

