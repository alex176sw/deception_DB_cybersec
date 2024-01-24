#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Alice', 'alice@example.com', '123 Main St', '1985-04-12', 'Female', 'Married', 'Software Engineer'),
(DEFAULT, 'Bob', 'bob@example.com', '456 Elm St', '1980-05-20', 'Male', 'Single', 'Sales Representative'),
(DEFAULT, 'Charlie', 'charlie@example.com', '789 Oak St', '1975-06-15', 'Male', 'Married', 'Marketing Manager'),
(DEFAULT, 'David', 'david@example.com', '321 Maple St', '1982-02-20', 'Male', 'Single', 'Graphic Designer'),
(DEFAULT, 'Emma', 'emma@example.com', '987 Cedar St', '1988-03-25', 'Female', 'Married', 'Teacher'),
(DEFAULT, 'Frank', 'frank@example.com', '678 Pine St', '1970-04-10', 'Male', 'Single', 'Lawyer');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'ABC Inc.', 'Software Development', '123 Main St'),
(DEFAULT, 'XYZ Corp.', 'Electronics Manufacturing', '456 Elm St'),
(DEFAULT, 'MNO LLC.', 'Financial Services', '789 Oak St'),
(DEFAULT, 'PQR Inc.', 'Healthcare', '321 Maple St'),
(DEFAULT, 'STU Ltd.', 'Retail', '987 Cedar St'),
(DEFAULT, 'VWX Corp.', 'Automotive', '678 Pine St');

EOSQL

