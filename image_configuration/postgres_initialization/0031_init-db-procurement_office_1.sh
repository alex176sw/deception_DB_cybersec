#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE DATABASE procurement_office_1 WITH OWNER j8;

EOSQL

