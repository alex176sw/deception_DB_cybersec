#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname post_office_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA post_office_n TO post_office;
	GRANT ALL ON SCHEMA post_office_n TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA post_office_n TO j6_chief;
	GRANT ALL ON SCHEMA post_office_n TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA post_office_n TO j1_chief;
	GRANT ALL ON SCHEMA post_office_n TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA post_office_n TO post_office;
	GRANT ALL ON SCHEMA post_office_n TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA post_office_n TO post_office;
	GRANT ALL ON SCHEMA post_office_n TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA post_office_n TO post_office;
	GRANT ALL ON SCHEMA post_office_n TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA post_office TO post_office;
	GRANT ALL ON SCHEMA post_office TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA post_office TO j6_chief;
	GRANT ALL ON SCHEMA post_office TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA post_office TO j1_chief;
	GRANT ALL ON SCHEMA post_office TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA post_office TO post_office;
	GRANT ALL ON SCHEMA post_office TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA post_office TO post_office;
	GRANT ALL ON SCHEMA post_office TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA post_office TO post_office;
	GRANT ALL ON SCHEMA post_office TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO post_office;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j6_chief;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j1_chief;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO post_office;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO post_office;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO post_office;
	GRANT ALL ON SCHEMA public TO j6;

EOSQL

