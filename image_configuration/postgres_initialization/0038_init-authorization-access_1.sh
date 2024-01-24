#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname access_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA access_garrison TO access;
	GRANT ALL ON SCHEMA access_garrison TO j2;
	GRANT SELECT ON ALL TABLES IN SCHEMA access_garrison TO j2_chief;
	GRANT ALL ON SCHEMA access_garrison TO j2;
	GRANT INSERT ON ALL TABLES IN SCHEMA access_garrison TO access;
	GRANT ALL ON SCHEMA access_garrison TO j2;
	GRANT UPDATE ON ALL TABLES IN SCHEMA access_garrison TO access;
	GRANT ALL ON SCHEMA access_garrison TO j2;
	GRANT DELETE ON ALL TABLES IN SCHEMA access_garrison TO access;
	GRANT ALL ON SCHEMA access_garrison TO j2;
	GRANT SELECT ON ALL TABLES IN SCHEMA access_closed TO access;
	GRANT ALL ON SCHEMA access_closed TO j2;
	GRANT SELECT ON ALL TABLES IN SCHEMA access_closed TO j2_chief;
	GRANT ALL ON SCHEMA access_closed TO j2;
	GRANT INSERT ON ALL TABLES IN SCHEMA access_closed TO access;
	GRANT ALL ON SCHEMA access_closed TO j2;
	GRANT UPDATE ON ALL TABLES IN SCHEMA access_closed TO access;
	GRANT ALL ON SCHEMA access_closed TO j2;
	GRANT DELETE ON ALL TABLES IN SCHEMA access_closed TO access;
	GRANT ALL ON SCHEMA access_closed TO j2;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO access;
	GRANT ALL ON SCHEMA public TO j2;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j2_chief;
	GRANT ALL ON SCHEMA public TO j2;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO access;
	GRANT ALL ON SCHEMA public TO j2;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO access;
	GRANT ALL ON SCHEMA public TO j2;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO access;
	GRANT ALL ON SCHEMA public TO j2;

EOSQL

