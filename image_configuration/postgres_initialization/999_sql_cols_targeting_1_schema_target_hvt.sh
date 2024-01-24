#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS target_hvt.PersonalData (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    marital_status VARCHAR(10) NOT NULL,
    occupation VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS target_hvt.Company (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    industry VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);
EOSQL

