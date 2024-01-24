#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname plan_ad_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS plan_ad_s;
	CREATE SCHEMA IF NOT EXISTS plan_ad_b;

EOSQL

