#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname procurement_office_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS procurement_office_n;
	CREATE SCHEMA IF NOT EXISTS procurement_office_o;

EOSQL

