#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Alice Smith', 'alice.smith@example.com', '123 Main St', '1985-06-14', 'Female', 'Married', 'Software Engineer'),
(DEFAULT, 'Bob Johnson', 'bob.johnson@example.com', '456 Elm St', '1975-02-20', 'Male', 'Single', 'Sales Representative'),
(DEFAULT, 'Charlie Brown', 'charlie.brown@example.com', '789 Oak St', '1965-04-03', 'Male', 'Married', 'Marketing Manager'),
(DEFAULT, 'David Lee', 'david.lee@example.com', '901 Maple St', '1982-01-22', 'Male', 'Single', 'Software Developer'),
(DEFAULT, 'Emily Chen', 'emily.chen@example.com', '111 Oak St', '1990-05-16', 'Female', 'Married', 'Graphic Designer'),
(DEFAULT, 'Frank Williams', 'frank.williams@example.com', '222 Main St', '1970-01-01', 'Male', 'Single', 'Business Analyst');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'ACME Inc', 'Software', '123 Main St'),
(DEFAULT, 'Beta Corp', 'Retail', '456 Elm St'),
(DEFAULT, 'Gamma Enterprises', 'Manufacturing', '789 Oak St'),
(DEFAULT, 'Delta Solutions', 'Finance', '901 Maple St'),
(DEFAULT, 'Epsilon Technologies', 'Healthcare', '222 Main St');

EOSQL

