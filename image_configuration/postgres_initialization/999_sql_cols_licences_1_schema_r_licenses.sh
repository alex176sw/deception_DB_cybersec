#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname licences_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS r_licenses.PersonalData (
personal_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
phone_number VARCHAR(20) NOT NULL,
address VARCHAR(100) NOT NULL,
city VARCHAR(50) NOT NULL,
state VARCHAR(50) NOT NULL,
zip_code VARCHAR(10) NOT NULL,
date_of_birth DATE NOT NULL,
gender VARCHAR(10) NOT NULL,
marital_status VARCHAR(10) NOT NULL,
emergency_contact_name VARCHAR(50) NOT NULL,
emergency_contact_relationship VARCHAR(50) NOT NULL,
emergency_contact_phone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS r_licenses.LicenseInformation (
license_id SERIAL PRIMARY KEY,
personal_id INT REFERENCES r_licenses.PersonalData(personal_id),
license_type VARCHAR(50) NOT NULL,
issue_date DATE NOT NULL,
expiration_date DATE NOT NULL,
renewal_date DATE,
fee DECIMAL(10, 2) NOT NULL
);

EOSQL

