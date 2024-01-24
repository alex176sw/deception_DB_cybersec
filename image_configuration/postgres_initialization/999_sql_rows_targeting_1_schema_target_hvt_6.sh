#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname targeting_1  <<-EOSQL

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'John Doe', 'johndoe@example.com', '123 Main St', '1980-01-01', 'Male', 'Married', 'Software Engineer');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Jane Doe', 'janedoe@example.com', '456 Elm St', '1985-02-02', 'Female', 'Single', 'Marketing Manager');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Bob Smith', 'bobsmith@example.com', '789 Oak St', '1975-03-03', 'Male', 'Married', 'Sales Representative');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Alice Johnson', 'alicejohnson@example.com', '901 Maple St', '1982-04-04', 'Female', 'Single', 'Graphic Designer');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Mike Brown', 'mikebrown@example.com', '1020 Pine St', '1978-05-05', 'Male', 'Married', 'Software Developer');

INSERT INTO target_hvt.PersonalData (id, name, email, address, date_of_birth, gender, marital_status, occupation) VALUES
(DEFAULT, 'Sarah Taylor', 'sarahtaylor@example.com', '1111 Oak St', '1988-06-06', 'Female', 'Single', 'Teacher');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'ABC Inc', 'Technology', '123 Main St');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'XYZ Corp', 'Finance', '456 Elm St');

INSERT INTO target_hvt.Company (id, name, industry, address) VALUES
(DEFAULT, 'MNO LLC', 'Healthcare', '789 Oak St');

EOSQL

