#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL
INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Alice Smith', 'alice.smith@example.com', '123 Main St', '1985-06-14', 'Female', 'Married', 'Software Engineer'),
(DEFAULT, 'Bob Johnson', 'bob.johnson@example.com', '456 Elm St', '1975-03-22', 'Male', 'Single', 'Sales Representative'),
(DEFAULT, 'Charlie Brown', 'charlie.brown@example.com', '789 Oak St', '1965-02-11', 'Male', 'Married', 'Marketing Manager'),
(DEFAULT, 'David Lee', 'david.lee@example.com', '901 Maple St', '1980-04-23', 'Male', 'Single', 'Graphic Designer'),
(DEFAULT, 'Emily Chen', 'emily.chen@example.com', '1025 Main St', '1990-07-22', 'Female', 'Married', 'Product Manager'),
(DEFAULT, 'Frank Williams', 'frank.williams@example.com', '648 Oak St', '1970-01-01', 'Male', 'Single', 'CEO');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'ACME Inc', 'Software', '123 Main St'),
(DEFAULT, 'Beta Corp', 'Electronics', '456 Elm St'),
(DEFAULT, 'Gamma Ltd', 'Finance', '789 Oak St'),
(DEFAULT, 'Delta Enterprises', 'Retail', '901 Maple St'),
(DEFAULT, 'Epsilon Solutions', 'Consulting', '1025 Main St'),
(DEFAULT, 'Zeta Industries', 'Manufacturing', '648 Oak St');
EOSQL

