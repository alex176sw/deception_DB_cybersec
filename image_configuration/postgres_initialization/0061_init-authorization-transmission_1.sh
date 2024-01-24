#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname transmission_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA transmission_n TO transmission;
	GRANT ALL ON SCHEMA transmission_n TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA transmission_n TO j6_chief;
	GRANT ALL ON SCHEMA transmission_n TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA transmission_n TO transmission;
	GRANT ALL ON SCHEMA transmission_n TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA transmission_n TO transmission;
	GRANT ALL ON SCHEMA transmission_n TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA transmission_n TO transmission;
	GRANT ALL ON SCHEMA transmission_n TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA transmission_o TO transmission;
	GRANT ALL ON SCHEMA transmission_o TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA transmission_o TO j6_chief;
	GRANT ALL ON SCHEMA transmission_o TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA transmission_o TO transmission;
	GRANT ALL ON SCHEMA transmission_o TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA transmission_o TO transmission;
	GRANT ALL ON SCHEMA transmission_o TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA transmission_o TO transmission;
	GRANT ALL ON SCHEMA transmission_o TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO transmission;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j6_chief;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO transmission;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO transmission;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO transmission;
	GRANT ALL ON SCHEMA public TO j6;

EOSQL

