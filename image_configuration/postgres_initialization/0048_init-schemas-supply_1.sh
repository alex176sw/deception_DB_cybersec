#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname supply_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS supply_w;
	CREATE SCHEMA IF NOT EXISTS supply_lt;

EOSQL

