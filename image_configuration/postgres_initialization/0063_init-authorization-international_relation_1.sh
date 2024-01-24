#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname international_relation_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA international_relation_n TO international_relation;
	GRANT ALL ON SCHEMA international_relation_n TO j7;
	GRANT SELECT ON ALL TABLES IN SCHEMA international_relation_n TO j7_chief;
	GRANT ALL ON SCHEMA international_relation_n TO j7;
	GRANT SELECT ON ALL TABLES IN SCHEMA international_relation_n TO j5_chief;
	GRANT ALL ON SCHEMA international_relation_n TO j7;
	GRANT INSERT ON ALL TABLES IN SCHEMA international_relation_n TO international_relation;
	GRANT ALL ON SCHEMA international_relation_n TO j7;
	GRANT UPDATE ON ALL TABLES IN SCHEMA international_relation_n TO international_relation;
	GRANT ALL ON SCHEMA international_relation_n TO j7;
	GRANT DELETE ON ALL TABLES IN SCHEMA international_relation_n TO international_relation;
	GRANT ALL ON SCHEMA international_relation_n TO j7;
	GRANT SELECT ON ALL TABLES IN SCHEMA international_relation TO international_relation;
	GRANT ALL ON SCHEMA international_relation TO j7;
	GRANT SELECT ON ALL TABLES IN SCHEMA international_relation TO j7_chief;
	GRANT ALL ON SCHEMA international_relation TO j7;
	GRANT SELECT ON ALL TABLES IN SCHEMA international_relation TO j5_chief;
	GRANT ALL ON SCHEMA international_relation TO j7;
	GRANT INSERT ON ALL TABLES IN SCHEMA international_relation TO international_relation;
	GRANT ALL ON SCHEMA international_relation TO j7;
	GRANT UPDATE ON ALL TABLES IN SCHEMA international_relation TO international_relation;
	GRANT ALL ON SCHEMA international_relation TO j7;
	GRANT DELETE ON ALL TABLES IN SCHEMA international_relation TO international_relation;
	GRANT ALL ON SCHEMA international_relation TO j7;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO international_relation;
	GRANT ALL ON SCHEMA public TO j7;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j7_chief;
	GRANT ALL ON SCHEMA public TO j7;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j5_chief;
	GRANT ALL ON SCHEMA public TO j7;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO international_relation;
	GRANT ALL ON SCHEMA public TO j7;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO international_relation;
	GRANT ALL ON SCHEMA public TO j7;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO international_relation;
	GRANT ALL ON SCHEMA public TO j7;

EOSQL

