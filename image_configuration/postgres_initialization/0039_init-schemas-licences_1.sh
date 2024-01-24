#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname licences_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS licenses;
	CREATE SCHEMA IF NOT EXISTS r_licenses;

EOSQL

