#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE DATABASE r_n_d_1 WITH OWNER j5;

EOSQL

