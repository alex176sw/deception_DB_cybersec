#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname helpdesk_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA helpdesk_w TO helpdesk;
	GRANT ALL ON SCHEMA helpdesk_w TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA helpdesk_w TO j6_chief;
	GRANT ALL ON SCHEMA helpdesk_w TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA helpdesk_w TO helpdesk;
	GRANT ALL ON SCHEMA helpdesk_w TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA helpdesk_w TO helpdesk;
	GRANT ALL ON SCHEMA helpdesk_w TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA helpdesk_w TO helpdesk;
	GRANT ALL ON SCHEMA helpdesk_w TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA helpdesk_lt TO helpdesk;
	GRANT ALL ON SCHEMA helpdesk_lt TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA helpdesk_lt TO j6_chief;
	GRANT ALL ON SCHEMA helpdesk_lt TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA helpdesk_lt TO helpdesk;
	GRANT ALL ON SCHEMA helpdesk_lt TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA helpdesk_lt TO helpdesk;
	GRANT ALL ON SCHEMA helpdesk_lt TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA helpdesk_lt TO helpdesk;
	GRANT ALL ON SCHEMA helpdesk_lt TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO helpdesk;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j6_chief;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO helpdesk;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO helpdesk;
	GRANT ALL ON SCHEMA public TO j6;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO helpdesk;
	GRANT ALL ON SCHEMA public TO j6;

EOSQL

