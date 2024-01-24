#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname ga_1  <<-EOSQL
	GRANT SELECT ON ALL TABLES IN SCHEMA general TO general_affairs;
	GRANT ALL ON SCHEMA general TO j1;
	GRANT SELECT ON ALL TABLES IN SCHEMA general TO j1_chief;
	GRANT ALL ON SCHEMA general TO j1;
	GRANT INSERT ON ALL TABLES IN SCHEMA general TO general_affairs;
	GRANT ALL ON SCHEMA general TO j1;
	GRANT UPDATE ON ALL TABLES IN SCHEMA general TO general_affairs;
	GRANT ALL ON SCHEMA general TO j1;
	GRANT DELETE ON ALL TABLES IN SCHEMA general TO general_affairs;
	GRANT ALL ON SCHEMA general TO j1;
	GRANT SELECT ON ALL TABLES IN SCHEMA affairs TO general_affairs;
	GRANT ALL ON SCHEMA affairs TO j1;
	GRANT SELECT ON ALL TABLES IN SCHEMA affairs TO j1_chief;
	GRANT ALL ON SCHEMA affairs TO j1;
	GRANT INSERT ON ALL TABLES IN SCHEMA affairs TO general_affairs;
	GRANT ALL ON SCHEMA affairs TO j1;
	GRANT UPDATE ON ALL TABLES IN SCHEMA affairs TO general_affairs;
	GRANT ALL ON SCHEMA affairs TO j1;
	GRANT DELETE ON ALL TABLES IN SCHEMA affairs TO general_affairs;
	GRANT ALL ON SCHEMA affairs TO j1;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO general_affairs;
	GRANT ALL ON SCHEMA public TO j1;
	GRANT SELECT ON ALL TABLES IN SCHEMA public TO j1_chief;
	GRANT ALL ON SCHEMA public TO j1;
	GRANT INSERT ON ALL TABLES IN SCHEMA public TO general_affairs;
	GRANT ALL ON SCHEMA public TO j1;
	GRANT UPDATE ON ALL TABLES IN SCHEMA public TO general_affairs;
	GRANT ALL ON SCHEMA public TO j1;
	GRANT DELETE ON ALL TABLES IN SCHEMA public TO general_affairs;
	GRANT ALL ON SCHEMA public TO j1;

EOSQL

