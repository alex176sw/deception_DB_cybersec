#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname w_n_a_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS w_n_a_w;
	CREATE SCHEMA IF NOT EXISTS w_n_a_lt;

EOSQL

