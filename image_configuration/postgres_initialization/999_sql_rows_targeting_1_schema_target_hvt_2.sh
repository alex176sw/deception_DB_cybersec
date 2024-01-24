#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL


INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Alice Smith', 'alice.smith@example.com', '123 Main St', '1985-06-14', 'Female', 'Married', 'Software Engineer');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Bob Johnson', 'bob.johnson@example.com', '456 Elm St', '1970-01-01', 'Male', 'Single', 'Sales Representative');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Charlie Brown', 'charlie.brown@example.com', '789 Oak St', '1965-02-20', 'Male', 'Married', 'Graphic Designer');


INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'Acme Inc', 'Retail', '123 Main St');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'Best Buy', 'Electronics', '456 Elm St');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'ABC Corporation', 'Finance', '789 Oak St');

EOSQL

