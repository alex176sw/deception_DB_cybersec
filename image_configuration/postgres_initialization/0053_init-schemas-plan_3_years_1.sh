#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname plan_3_years_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS plan_3_years;

EOSQL

