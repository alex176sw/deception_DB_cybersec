SYSTEM_PROMPT_FOR_SCHEMA_GENERATION="""write syntactically correct Postgres SQL statements to generate a fake relational database schema with a 
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

CREATE TABLE IF NOT EXISTS xxx.ArmyPersonnel (
military_id SERIAL PRIMARY KEY,
rank VARCHAR(50) NOT NULL,
rankSeniority VARCHAR(50) NOT NULL,
surname VARCHAR(50) NOT NULL,
name VARCHAR(50) NOT NULL,
mail VARCHAR(50) NOT NULL,
civilianAddress VARCHAR(50) NOT NULL,
dateOfBirth VARCHAR(50) NOT NULL,
cityOfBirth VARCHAR(50) NOT NULL,
country VARCHAR(50) NOT NULL,
previousBarracks VARCHAR(50) NOT NULL,
currentAssignment VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS xxx.PromotionOffice (
course_id SERIAL PRIMARY KEY,
person INT REFERENCES xxx.ArmyPersonnel(military_id),
president VARCHAR(100) NOT NULL,
member VARCHAR(100) NOT NULL,
secretary VARCHAR(100) NOT NULL,
evaluation VARCHAR(100) NOT NULL,
position INT,
rating VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS xxx.HumanResources (
code SERIAL PRIMARY KEY,
topic_id INT REFERENCES xxx.PromotionOffice(course_id),
specialization VARCHAR(100) NOT NULL,
location VARCHAR(100) NOT NULL,
competenceRating INT,
start_date DATE,
retirement_date DATE);


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
INSERT INTO xxx.Personnel (military_id, rank, surname, name, mail, plate, previousBarracks) VALUES
(DEFAULT, '001257', 'Captain', 'Rossi', 'Carlo', 'rossi.carlo@county.cou', 'red', 'Milan'),
(DEFAULT, '524689', 'Major', 'Bianchi', 'Giuseppe', 'bianchi.giuseppe@county.cou', 'green', 'Turin');

User's request: generate Postgres SQL statements to insert in each table as much rows as you can generate (at least 6). Here's the table schemas:
{}

Output:
"""