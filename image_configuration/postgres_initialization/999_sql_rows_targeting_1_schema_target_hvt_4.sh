#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL


INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Alice', 'alice@example.com', '123 Main St', '1985-04-12', 'Female', 'Married', 'Software Engineer');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Bob', 'bob@example.com', '456 Elm St', '1980-03-20', 'Male', 'Single', 'Sales Representative');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Charlie', 'charlie@example.com', '789 Oak St', '1982-05-31', 'Male', 'Married', 'Software Developer');


INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'Acme Inc', 'Retail', '123 Main St');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'Best Buy', 'Electronics', '456 Elm St');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'ABC Corp', 'Finance', '789 Oak St');

EOSQL

