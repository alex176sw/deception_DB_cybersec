#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname plan_24_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS plan_24_r;
	CREATE SCHEMA IF NOT EXISTS plan_24_f;

EOSQL

