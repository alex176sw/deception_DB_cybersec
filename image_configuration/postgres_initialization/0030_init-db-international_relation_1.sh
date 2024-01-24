#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE DATABASE international_relation_1 WITH OWNER j7;

EOSQL

