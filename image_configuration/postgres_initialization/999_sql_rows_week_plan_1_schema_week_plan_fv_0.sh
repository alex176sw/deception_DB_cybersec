#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname week_plan_1  <<-EOSQL

INSERT INTO week_plan_fv.employees (employee_id, first_name, last_name, email, phone, department, job_title, hire_date, salary) VALUES
(DEFAULT, 'John', 'Doe', 'johndoe@example.com', '555-1234', 'Sales', 'Manager', '2022-01-01', 50000),
(DEFAULT, 'Jane', 'Smith', 'janesmith@example.com', '555-5678', 'Marketing', 'Executive', '2022-01-15', 70000),
(DEFAULT, 'Bob', 'Brown', 'bob brown@example.com', '555-9012', 'IT', 'Director', '2022-02-01', 80000),
(DEFAULT, 'Alice', 'Green', 'alice green@example.com', '555-1111', 'Human Resources', 'Manager', '2022-03-01', 60000),
(DEFAULT, 'Mike', 'Davis', 'mikedavis@example.com', '555-2222', 'Finance', 'Director', '2022-04-01', 90000),
(DEFAULT, 'Samantha', 'Rodriguez', 'samantharodriguez@example.com', '555-3333', 'Legal', 'Counsel', '2022-05-01', 100000);

INSERT INTO week_plan_fv.tasks (task_id, title, assignee, priority, due_date, status) VALUES
(DEFAULT, 'Task 1', 1, 0, '2022-01-15', 'incomplete'),
(DEFAULT, 'Task 2', 2, 0, '2022-02-01', 'incomplete'),
(DEFAULT, 'Task 3', 3, 0, '2022-03-01', 'incomplete'),
(DEFAULT, 'Task 4', 4, 0, '2022-04-01', 'incomplete'),
(DEFAULT, 'Task 5', 5, 0, '2022-05-01', 'incomplete');

INSERT INTO week_plan_fv.projects (project_id, name, start_date, end_date, budget) VALUES
(DEFAULT, 'Project 1', '2022-01-01', '2022-03-31', 10000),
(DEFAULT, 'Project 2', '2022-02-01', '2022-05-31', 20000),
(DEFAULT, 'Project 3', '2022-03-01', '2022-07-31', 30000);

INSERT INTO week_plan_fv.task_assignments (task_assignment_id, task_id, employee_id, start_date, end_date, status) VALUES
(DEFAULT, 1, 1, '2022-01-15', '2022-02-15', 'incomplete'),
(DEFAULT, 2, 2, '2022-02-01', '2022-03-01', 'incomplete'),
(DEFAULT, 3, 3, '2022-03-01', '2022-04-01', 'incomplete'),
(DEFAULT, 4, 4, '2022-04-01', '2022-05-01', 'incomplete'),
(DEFAULT, 5, 5, '2022-05-01', '2022-06-01', 'incomplete');

INSERT INTO week_plan_fv.time_tracking (time_id, task_assignment_id, employee_id, total_time) VALUES
(DEFAULT, 1, 1, 10),
(DEFAULT, 2, 2, 20),
(DEFAULT, 3, 3, 30),
(DEFAULT, 4, 4, 40),
(DEFAULT, 5, 5, 50);

INSERT INTO week_plan_fv.comments (comment_id, task_id) VALUES
(DEFAULT, 1),
(DEFAULT, 2),
(DEFAULT, 3),
(DEFAULT, 4),
(DEFAULT, 5);

EOSQL

