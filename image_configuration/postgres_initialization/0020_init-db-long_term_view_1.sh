#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE DATABASE long_term_view_1 WITH OWNER j5;

EOSQL

