#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname med_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA med_w TO med;
	GRANT ALL ON SCHEMA med_w TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA med_w TO j1_chief;
	GRANT ALL ON SCHEMA med_w TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA med_w TO j4_chief;
	GRANT ALL ON SCHEMA med_w TO j4;
	GRANT INSERT ON ALL TABLES IN SCHEMA med_w TO med;
	GRANT ALL ON SCHEMA med_w TO j4;
	GRANT UPDATE ON ALL TABLES IN SCHEMA med_w TO med;
	GRANT ALL ON SCHEMA med_w TO j4;
	GRANT DELETE ON ALL TABLES IN SCHEMA med_w TO med;
	GRANT ALL ON SCHEMA med_w TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA med_lt TO med;
	GRANT ALL ON SCHEMA med_lt TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA med_lt TO j1_chief;
	GRANT ALL ON SCHEMA med_lt TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA med_lt TO j4_chief;
	GRANT ALL ON SCHEMA med_lt TO j4;
	GRANT INSERT ON ALL TABLES IN SCHEMA med_lt TO med;
	GRANT ALL ON SCHEMA med_lt TO j4;
	GRANT UPDATE ON ALL TABLES IN SCHEMA med_lt TO med;
	GRANT ALL ON SCHEMA med_lt TO j4;
	GRANT DELETE ON ALL TABLES IN SCHEMA med_lt TO med;
	GRANT ALL ON SCHEMA med_lt TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO med;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j1_chief;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j4_chief;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO med;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO med;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO med;
	GRANT ALL ON SCHEMA public TO j4;

EOSQL

