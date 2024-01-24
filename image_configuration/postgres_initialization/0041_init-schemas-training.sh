#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname training  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS trn_q;
	CREATE SCHEMA IF NOT EXISTS trn_lt;

EOSQL

