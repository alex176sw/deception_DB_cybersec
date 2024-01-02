SYSTEM_PROMPT_FOR_SCHEMA_GENERATION="""write syntactically 
correct Postgres SQL statements to generate a fake relational database schema with a 
realistic and complex structure, including appropriate attributes and relationships. 
create from scratch table names, attribute names and data types for each table 
as well as relationships between tables. 
Exclude any natural language descriptions, explanations or inline comments 
in the SQL response, since it will be used by an application code that have to execute 
the actions.


Here's an example:
User's request: generate SQL code to create a relational database schema for a cars 
manufactoring company, composed by at least 3 tables, inside the schema xxx.

Output:

CREATE TABLE IF NOT EXISTS xxx.Manufacturer (
    manufacturer_id SERIAL,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(50) NOT NULL,
    PRIMARY KEY (manufacturer_id)
);

CREATE TABLE IF NOT EXISTS xxx.CarModel (
    model_id SERIAL,
    manufacturer_id INT REFERENCES xxx.Manufacturer(manufacturer_id),
    name VARCHAR(100) NOT NULL,
    release_year INT,
    engine_type VARCHAR(50),
    PRIMARY KEY (model_id, manufacturer_id)
);

CREATE TABLE IF NOT EXISTS xxx.ProductionFacility (
    facility_id SERIAL,
    manufacturer_id INT REFERENCES xxx.Manufacturer(manufacturer_id),
    location VARCHAR(100) NOT NULL,
    capacity INT,
    production_start_date DATE,
    production_end_date DATE,
    PRIMARY KEY (facility_id, manufacturer_id)
);

User's request: generate the Postgres SQL statements to create at least {} tables for a
relational database about {}, inside the schema {}.

Output:
"""


SYSTEM_PROMPT_FOR_REVIEW="""You are provided with Postgres SQL statements and an error description. 
Your job is to write the correct version of the Postgres SQL statements. Do not add any natural language 
explanation or inline comments, write just SQL code. Put a semi-colon ; to close each statement.

Error: {}
Postgres SQL statements that caused the error: 
{}
"""


SYSTEM_PROMPT_FOR_ROWS_GENERATION="""As a skilled Postgres SQL programmer, write a syntatically correct Postgres SQL 
statements to insert fake but realistic-looking data into a relational database schema.
If a string contains a single quote, you need to skip it by using two consecutive single quotes.
Put a semi-colon ; to close each INSERT statement.
Do not respond with any natural language descriptions, explanations or inline comments, write just SQL code.

Example: 
INSERT INTO xxx.CarCompany (car_id, name, description, manufactor_id) VALUES
(DEFAULT, 'AudiA8', 'Sales department''s best rated car', null),
(DEFAULT 'Ferrari', 'The best car ever', null);

User's request: generate Postgres SQL statements to insert in each table as much rows as you can generate (at least 6). Here's the table schemas:
{}

Output:
"""