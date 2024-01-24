#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname ga_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS general.Politicians (
id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
party_affiliation VARCHAR(50) NOT NULL,
position VARCHAR(50) NOT NULL,
contact_info VARCHAR(100) NOT NULL,
educational_background VARCHAR(100) NOT NULL,
birthdate DATE NOT NULL,
photo VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS general.GovernmentOfficials (
id SERIAL PRIMARY KEY,
politician_id INT REFERENCES general.Politicians(id),
position VARCHAR(50) NOT NULL,
department VARCHAR(50) NOT NULL,
salary INT NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS general.Bills (
id SERIAL PRIMARY KEY,
title VARCHAR(100) NOT NULL,
description VARCHAR(200) NOT NULL,
sponsor_id INT REFERENCES general.Politicians(id),
status VARCHAR(50) NOT NULL,
passed DATE NOT NULL,
vetoed DATE NOT NULL
);

EOSQL

