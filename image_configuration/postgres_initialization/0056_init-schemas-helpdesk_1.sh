#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname helpdesk_1  <<-EOSQL
	CREATE SCHEMA IF NOT EXISTS helpdesk_w;
	CREATE SCHEMA IF NOT EXISTS helpdesk_lt;

EOSQL

