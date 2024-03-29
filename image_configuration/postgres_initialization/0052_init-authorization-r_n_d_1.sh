#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname r_n_d_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA r_n_d_w TO r_n_d;
	GRANT ALL ON SCHEMA r_n_d_w TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA r_n_d_w TO j5_chief;
	GRANT ALL ON SCHEMA r_n_d_w TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA r_n_d_w TO r_n_d;
	GRANT ALL ON SCHEMA r_n_d_w TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA r_n_d_w TO j5_chief;
	GRANT ALL ON SCHEMA r_n_d_w TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA r_n_d_w TO r_n_d;
	GRANT ALL ON SCHEMA r_n_d_w TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA r_n_d_w TO j5_chief;
	GRANT ALL ON SCHEMA r_n_d_w TO j5;
	GRANT DELETE ON ALL TABLES IN SCHEMA r_n_d_w TO r_n_d;
	GRANT ALL ON SCHEMA r_n_d_w TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA r_n_d_lt TO r_n_d;
	GRANT ALL ON SCHEMA r_n_d_lt TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA r_n_d_lt TO j5_chief;
	GRANT ALL ON SCHEMA r_n_d_lt TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA r_n_d_lt TO r_n_d;
	GRANT ALL ON SCHEMA r_n_d_lt TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA r_n_d_lt TO j5_chief;
	GRANT ALL ON SCHEMA r_n_d_lt TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA r_n_d_lt TO r_n_d;
	GRANT ALL ON SCHEMA r_n_d_lt TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA r_n_d_lt TO j5_chief;
	GRANT ALL ON SCHEMA r_n_d_lt TO j5;
	GRANT DELETE ON ALL TABLES IN SCHEMA r_n_d_lt TO r_n_d;
	GRANT ALL ON SCHEMA r_n_d_lt TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO r_n_d;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j5_chief;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO r_n_d;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO j5_chief;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO r_n_d;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO j5_chief;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO r_n_d;
	GRANT ALL ON SCHEMA public TO j5;

EOSQL

