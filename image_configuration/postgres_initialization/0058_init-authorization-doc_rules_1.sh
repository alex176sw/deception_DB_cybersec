#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname doc_rules_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA doc_rules_w TO doc_rules;
	GRANT ALL ON SCHEMA doc_rules_w TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA doc_rules_w TO j6_chief;
	GRANT ALL ON SCHEMA doc_rules_w TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA doc_rules_w TO doc_rules;
	GRANT ALL ON SCHEMA doc_rules_w TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA doc_rules_w TO doc_rules;
	GRANT ALL ON SCHEMA doc_rules_w TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA doc_rules_w TO doc_rules;
	GRANT ALL ON SCHEMA doc_rules_w TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA doc_rules_lt TO doc_rules;
	GRANT ALL ON SCHEMA doc_rules_lt TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA doc_rules_lt TO j6_chief;
	GRANT ALL ON SCHEMA doc_rules_lt TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA doc_rules_lt TO doc_rules;
	GRANT ALL ON SCHEMA doc_rules_lt TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA doc_rules_lt TO doc_rules;
	GRANT ALL ON SCHEMA doc_rules_lt TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA doc_rules_lt TO doc_rules;
	GRANT ALL ON SCHEMA doc_rules_lt TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO doc_rules;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j6_chief;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO doc_rules;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO doc_rules;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO doc_rules;
	GRANT ALL ON SCHEMA public TO j6;

EOSQL

