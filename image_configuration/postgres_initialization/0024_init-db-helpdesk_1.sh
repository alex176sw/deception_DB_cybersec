#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE DATABASE helpdesk_1 WITH OWNER j6;

EOSQL

