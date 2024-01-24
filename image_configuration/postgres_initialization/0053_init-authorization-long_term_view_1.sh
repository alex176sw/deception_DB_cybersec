#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname long_term_view_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA long_term_view_lt TO long_term_view;
	GRANT ALL ON SCHEMA long_term_view_lt TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA long_term_view_lt TO plan_5_years;
	GRANT ALL ON SCHEMA long_term_view_lt TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA long_term_view_lt TO j5_chief;
	GRANT ALL ON SCHEMA long_term_view_lt TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA long_term_view_lt TO long_term_view;
	GRANT ALL ON SCHEMA long_term_view_lt TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA long_term_view_lt TO j5_chief;
	GRANT ALL ON SCHEMA long_term_view_lt TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA long_term_view_lt TO long_term_view;
	GRANT ALL ON SCHEMA long_term_view_lt TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA long_term_view_lt TO j5_chief;
	GRANT ALL ON SCHEMA long_term_view_lt TO j5;
	GRANT DELETE ON ALL TABLES IN SCHEMA long_term_view_lt TO long_term_view;
	GRANT ALL ON SCHEMA long_term_view_lt TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO long_term_view;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO plan_5_years;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j5_chief;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO long_term_view;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO j5_chief;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO long_term_view;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO j5_chief;
	GRANT ALL ON SCHEMA public TO j5;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO long_term_view;
	GRANT ALL ON SCHEMA public TO j5;

EOSQL

