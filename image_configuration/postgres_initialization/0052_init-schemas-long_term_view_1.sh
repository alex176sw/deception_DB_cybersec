#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname long_term_view_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS long_term_view_lt;

EOSQL

