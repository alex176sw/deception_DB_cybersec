#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname r_n_d_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS r_n_d_w;
	CREATE SCHEMA IF NOT EXISTS r_n_d_lt;

EOSQL

