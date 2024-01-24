#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE DATABASE w_n_a_1 WITH OWNER j4;

EOSQL

