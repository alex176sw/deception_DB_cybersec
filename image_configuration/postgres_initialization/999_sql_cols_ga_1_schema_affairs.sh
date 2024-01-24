#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname ga_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS affairs.ExecutiveSecretary (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

CREATE TABLE IF NOT EXISTS affairs.Meeting (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    location VARCHAR(100) NOT NULL,
    attendees INT REFERENCES affairs.ExecutiveSecretary(id)
);

CREATE TABLE IF NOT EXISTS affairs.Task (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    due_date DATE NOT NULL,
    assigned_to INT REFERENCES affairs.ExecutiveSecretary(id),
    meeting_id INT REFERENCES affairs.Meeting(id)
);



EOSQL

