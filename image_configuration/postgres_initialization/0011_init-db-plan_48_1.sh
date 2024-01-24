#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE DATABASE plan_48_1 WITH OWNER j3;

EOSQL

