#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname maint_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS maint_w;
	CREATE SCHEMA IF NOT EXISTS maint_d;

EOSQL

