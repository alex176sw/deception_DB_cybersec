#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname plan_ow_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS plan_ow_n;
	CREATE SCHEMA IF NOT EXISTS plan_ow_lt;

EOSQL

