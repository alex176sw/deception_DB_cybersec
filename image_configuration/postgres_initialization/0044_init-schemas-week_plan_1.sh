#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname week_plan_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS week_plan_r;
	CREATE SCHEMA IF NOT EXISTS week_plan_fv;

EOSQL

