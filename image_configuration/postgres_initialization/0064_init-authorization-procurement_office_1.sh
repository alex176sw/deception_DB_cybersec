#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname procurement_office_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA procurement_office_n TO procurement_office;
	GRANT ALL ON SCHEMA procurement_office_n TO j8;
	GRANT SELECT ON ALL TABLES IN SCHEMA procurement_office_n TO j8_chief;
	GRANT ALL ON SCHEMA procurement_office_n TO j8;
	GRANT SELECT ON ALL TABLES IN SCHEMA procurement_office_n TO j4_chief;
	GRANT ALL ON SCHEMA procurement_office_n TO j8;
	GRANT INSERT ON ALL TABLES IN SCHEMA procurement_office_n TO procurement_office;
	GRANT ALL ON SCHEMA procurement_office_n TO j8;
	GRANT UPDATE ON ALL TABLES IN SCHEMA procurement_office_n TO procurement_office;
	GRANT ALL ON SCHEMA procurement_office_n TO j8;
	GRANT DELETE ON ALL TABLES IN SCHEMA procurement_office_n TO procurement_office;
	GRANT ALL ON SCHEMA procurement_office_n TO j8;
	GRANT SELECT ON ALL TABLES IN SCHEMA procurement_office_o TO procurement_office;
	GRANT ALL ON SCHEMA procurement_office_o TO j8;
	GRANT SELECT ON ALL TABLES IN SCHEMA procurement_office_o TO j8_chief;
	GRANT ALL ON SCHEMA procurement_office_o TO j8;
	GRANT SELECT ON ALL TABLES IN SCHEMA procurement_office_o TO j4_chief;
	GRANT ALL ON SCHEMA procurement_office_o TO j8;
	GRANT INSERT ON ALL TABLES IN SCHEMA procurement_office_o TO procurement_office;
	GRANT ALL ON SCHEMA procurement_office_o TO j8;
	GRANT UPDATE ON ALL TABLES IN SCHEMA procurement_office_o TO procurement_office;
	GRANT ALL ON SCHEMA procurement_office_o TO j8;
	GRANT DELETE ON ALL TABLES IN SCHEMA procurement_office_o TO procurement_office;
	GRANT ALL ON SCHEMA procurement_office_o TO j8;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO procurement_office;
	GRANT ALL ON SCHEMA public TO j8;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j8_chief;
	GRANT ALL ON SCHEMA public TO j8;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j4_chief;
	GRANT ALL ON SCHEMA public TO j8;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO procurement_office;
	GRANT ALL ON SCHEMA public TO j8;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO procurement_office;
	GRANT ALL ON SCHEMA public TO j8;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO procurement_office;
	GRANT ALL ON SCHEMA public TO j8;

EOSQL

