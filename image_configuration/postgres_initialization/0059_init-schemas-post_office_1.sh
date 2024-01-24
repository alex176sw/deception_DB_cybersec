#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname post_office_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS post_office_n;
	CREATE SCHEMA IF NOT EXISTS post_office;

EOSQL

