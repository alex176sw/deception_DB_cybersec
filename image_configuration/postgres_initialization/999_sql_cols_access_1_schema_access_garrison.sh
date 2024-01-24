#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname access_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS access_garrison.PersonalData (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zipCode VARCHAR(10) NOT NULL,
    dateOfBirth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    maritalStatus VARCHAR(20) NOT NULL,
    occupation VARCHAR(50) NOT NULL,
    employer VARCHAR(100) NOT NULL,
    jobTitle VARCHAR(50) NOT NULL,
    salary INT NOT NULL,
    hireDate DATE NOT NULL,
    emergencyContact VARCHAR(100) NOT NULL,
    referenceCheck VARCHAR(20) NOT NULL,
    backgroundCheck VARCHAR(20) NOT NULL,
    citizenship VARCHAR(50) NOT NULL,
    educationLevel VARCHAR(50) NOT NULL,
    workExperience INT NOT NULL,
    skills VARCHAR(100) NOT NULL,
    languageSkills VARCHAR(50) NOT NULL,
    computerSkills VARCHAR(50) NOT NULL,
    certifications VARCHAR(50) NOT NULL,
    licenses VARCHAR(50) NOT NULL,
    securityClearance VARCHAR(50) NOT NULL,
    photo VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS access_garrison.EmployeeData (
    id SERIAL PRIMARY KEY,
    employeeID INT REFERENCES access_garrison.PersonalData(id),
    jobTitle VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    supervisor VARCHAR(50) NOT NULL,
    hireDate DATE NOT NULL,
    salary INT NOT NULL,
    performanceRating INT NOT NULL,
    bonus INT NOT NULL,
    commission INT NOT NULL,
    overtime INT NOT NULL,
    leaveBalance INT NOT NULL,
    sickLeave INT NOT NULL,
    vacationDays INT NOT NULL,
    trainingHours INT NOT NULL,
    employeePhoto VARCHAR(20) NOT NULL
);
EOSQL

