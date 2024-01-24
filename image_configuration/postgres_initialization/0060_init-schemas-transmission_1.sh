#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname transmission_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS transmission_n;
	CREATE SCHEMA IF NOT EXISTS transmission_o;

EOSQL

