#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname w_n_a_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA w_n_a_w TO w_n_a;
	GRANT ALL ON SCHEMA w_n_a_w TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA w_n_a_w TO j4_chief;
	GRANT ALL ON SCHEMA w_n_a_w TO j4;
	GRANT INSERT ON ALL TABLES IN SCHEMA w_n_a_w TO w_n_a;
	GRANT ALL ON SCHEMA w_n_a_w TO j4;
	GRANT UPDATE ON ALL TABLES IN SCHEMA w_n_a_w TO w_n_a;
	GRANT ALL ON SCHEMA w_n_a_w TO j4;
	GRANT DELETE ON ALL TABLES IN SCHEMA w_n_a_w TO w_n_a;
	GRANT ALL ON SCHEMA w_n_a_w TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA w_n_a_lt TO w_n_a;
	GRANT ALL ON SCHEMA w_n_a_lt TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA w_n_a_lt TO j4_chief;
	GRANT ALL ON SCHEMA w_n_a_lt TO j4;
	GRANT INSERT ON ALL TABLES IN SCHEMA w_n_a_lt TO w_n_a;
	GRANT ALL ON SCHEMA w_n_a_lt TO j4;
	GRANT UPDATE ON ALL TABLES IN SCHEMA w_n_a_lt TO w_n_a;
	GRANT ALL ON SCHEMA w_n_a_lt TO j4;
	GRANT DELETE ON ALL TABLES IN SCHEMA w_n_a_lt TO w_n_a;
	GRANT ALL ON SCHEMA w_n_a_lt TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO w_n_a;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j4_chief;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO w_n_a;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO w_n_a;
	GRANT ALL ON SCHEMA public TO j4;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO w_n_a;
	GRANT ALL ON SCHEMA public TO j4;

EOSQL
