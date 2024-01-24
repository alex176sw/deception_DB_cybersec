#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname com_plan_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS com_plan_w;
	CREATE SCHEMA IF NOT EXISTS doc_rules_lt;

EOSQL

