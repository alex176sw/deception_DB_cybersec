#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname week_plan_1  <<-EOSQL

CREATE TABLE IF NOT EXISTS week_plan_fv.employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    department VARCHAR(255) NOT NULL,
    job_title VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL,
    salary INT NOT NULL
);

CREATE TABLE IF NOT EXISTS week_plan_fv.tasks (
    task_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    assignee INT REFERENCES week_plan_fv.employees(employee_id),
    priority INT NOT NULL DEFAULT 0,
    due_date DATE NOT NULL,
    status VARCHAR(255) NOT NULL DEFAULT 'incomplete'
);

CREATE TABLE IF NOT EXISTS week_plan_fv.projects (
    project_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    budget INT NOT NULL,
    status VARCHAR(255) NOT NULL DEFAULT 'active'
);

CREATE TABLE IF NOT EXISTS week_plan_fv.task_assignments (
    task_assignment_id SERIAL PRIMARY KEY,
    task_id INT REFERENCES week_plan_fv.tasks(task_id),
    employee_id INT REFERENCES week_plan_fv.employees(employee_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(255) NOT NULL DEFAULT 'incomplete'
);

CREATE TABLE IF NOT EXISTS week_plan_fv.time_tracking (
    time_id SERIAL PRIMARY KEY,
    task_assignment_id INT REFERENCES week_plan_fv.task_assignments(task_assignment_id),
    employee_id INT REFERENCES week_plan_fv.employees(employee_id),
    total_time INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS week_plan_fv.comments (
    comment_id SERIAL PRIMARY KEY,
    task_id INT REFERENCES week_plan_fv.tasks(task_id)
);

EOSQL

