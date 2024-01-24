#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname w_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS taxes.Consultants (
consultant_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
surname VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
phone VARCHAR(20) NOT NULL,
address VARCHAR(100) NOT NULL,
city VARCHAR(50) NOT NULL,
state VARCHAR(50) NOT NULL,
zip_code VARCHAR(20) NOT NULL,
country VARCHAR(50) NOT NULL,
experience INT NOT NULL,
specialty VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS taxes.Clients (
client_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
surname VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
phone VARCHAR(20) NOT NULL,
address VARCHAR(100) NOT NULL,
city VARCHAR(50) NOT NULL,
state VARCHAR(50) NOT NULL,
zip_code VARCHAR(20) NOT NULL,
country VARCHAR(50) NOT NULL,
tax_consultant INT REFERENCES taxes.Consultants(consultant_id),
tax_return DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS taxes.TaxReturns (
tax_return_id SERIAL PRIMARY KEY,
client_id INT REFERENCES taxes.Clients(client_id),
consultant_id INT REFERENCES taxes.Consultants(consultant_id),
tax_year VARCHAR(4) NOT NULL,
gross_income DECIMAL(10, 2) NOT NULL,
taxes_paid DECIMAL(10, 2) NOT NULL,
net_income DECIMAL(10, 2) NOT NULL,
tax_consulting_fee DECIMAL(10, 2) NOT NULL,
other_expenses DECIMAL(10, 2) NOT NULL,
total_deductions DECIMAL(10, 2) NOT NULL,
tax_liability DECIMAL(10, 2) NOT NULL,
paid_on DATE NOT NULL,
due_date DATE NOT NULL
);

EOSQL

