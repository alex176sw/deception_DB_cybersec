#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname plan_48_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS plan_48_r;
	CREATE SCHEMA IF NOT EXISTS plan_48_f;

EOSQL

