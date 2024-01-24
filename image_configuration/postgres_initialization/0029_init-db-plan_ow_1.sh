#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE DATABASE plan_ow_1 WITH OWNER j7;

EOSQL

