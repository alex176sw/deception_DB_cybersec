#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA target_p TO targeting;
	GRANT ALL ON SCHEMA target_p TO j2;
	GRANT INSERT ON ALL TABLES IN SCHEMA target_p TO targeting;
	GRANT ALL ON SCHEMA target_p TO j2;
	GRANT UPDATE ON ALL TABLES IN SCHEMA target_p TO targeting;
	GRANT ALL ON SCHEMA target_p TO j2;
	GRANT DELETE ON ALL TABLES IN SCHEMA target_p TO targeting;
	GRANT ALL ON SCHEMA target_p TO j2;
	GRANT SELECT ON ALL TABLES IN SCHEMA target_hvt TO targeting;
	GRANT ALL ON SCHEMA target_hvt TO j2;
	GRANT INSERT ON ALL TABLES IN SCHEMA target_hvt TO targeting;
	GRANT ALL ON SCHEMA target_hvt TO j2;
	GRANT UPDATE ON ALL TABLES IN SCHEMA target_hvt TO targeting;
	GRANT ALL ON SCHEMA target_hvt TO j2;
	GRANT DELETE ON ALL TABLES IN SCHEMA target_hvt TO targeting;
	GRANT ALL ON SCHEMA target_hvt TO j2;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO targeting;
	GRANT ALL ON SCHEMA public TO j2;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO targeting;
	GRANT ALL ON SCHEMA public TO j2;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO targeting;
	GRANT ALL ON SCHEMA public TO j2;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO targeting;
	GRANT ALL ON SCHEMA public TO j2;

EOSQL

