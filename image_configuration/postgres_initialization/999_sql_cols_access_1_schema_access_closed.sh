#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname access_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS access_closed.Employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    salary INT NOT NULL
);

CREATE TABLE IF NOT EXISTS access_closed.Departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    manager_id INT REFERENCES access_closed.Employees (employee_id)
);

CREATE TABLE IF NOT EXISTS access_closed.Jobs (
    job_id SERIAL PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    department_id INT REFERENCES access_closed.Departments (department_id),
    salary INT NOT NULL,
    experience INT NOT NULL,
    education_level VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS access_closed.Skills (
    skill_id SERIAL PRIMARY KEY,
    skill_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS access_closed.EmployeeSkills (
    employee_skill_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES access_closed.Employees (employee_id),
    skill_id INT REFERENCES access_closed.Skills (skill_id)
);

CREATE TABLE IF NOT EXISTS access_closed.Projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES access_closed.Departments (department_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    budget INT NOT NULL
);

CREATE TABLE IF NOT EXISTS access_closed.EmployeeProjects (
    employee_project_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES access_closed.Employees (employee_id),
    project_id INT REFERENCES access_closed.Projects (project_id)
);

CREATE TABLE IF NOT EXISTS access_closed.Task (
    task_id SERIAL PRIMARY KEY,
    project_id INT REFERENCES access_closed.Projects (project_id)
);
EOSQL

