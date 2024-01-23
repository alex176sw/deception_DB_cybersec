import os
import psycopg2
from pathlib import Path 
from time import sleep

CONF_PATH: Path = Path("image_configuration/postgres_configurations")
POSTGRES_SCRIPTS_PATH: Path = Path("image_configuration/postgres_initialization")
HBA_TEMPLATE: Path = Path(f"{CONF_PATH}/pg_hba.conf.template")
POSTGRES_TEMPLATE: Path = Path(f"{CONF_PATH}/postgres.conf.template")

def start_psql_query(add_shebang=True, db_name: str = None, execute_as_user="postgres"):
    if add_shebang:
        s = "#!/bin/bash\nset -e\n"
    else:
        s = ""
    s += f"psql -v ON_ERROR_STOP=1 --username {execute_as_user}"
    if db_name is not None:
        s += f" --dbname {db_name} "
    s += " <<-EOSQL\n"
    return s

def close_psql_query():
    return "\nEOSQL\n\n"

def write_psql_script(output_file, db_name, execute_as_user, content: str):
    s = start_psql_query(add_shebang=True, db_name=db_name, execute_as_user=execute_as_user)
    s += content
    s += close_psql_query()
    with open(output_file, "w") as f:
        f.write(s)
    
params = dict(
        host="172.17.0.2",
        user="postgres",
        password="postgres",
        port=5432
    )

def start_postgres_sandbox_container():
    print("Starting Postgres sandbox container")
    os.system("docker container stop sandbox-postgres")
    os.system("docker container rm sandbox-postgres")
    os.system("docker run --name sandbox-postgres -p 9999:5432 -e POSTGRES_PASSWORD=postgres -d postgres:16.1")
    sleep(5)

def check_db_connection():
    print (params)
    try:
        conn = psycopg2.connect(**params)
        conn.close()
        print("Connection to Postgres is established")
        return True
    except Exception as e:
        print("Connection to Postgres is not established")
        print(e)
        return False

def clean_postgres(schemas):
    conn = psycopg2.connect(**params)
    cur = conn.cursor()
    for s in schemas:
        try:
            cur.execute(f"DROP SCHEMA {s} CASCADE;")
            cur.close()
            conn.commit()
        except (Exception, psycopg2.DatabaseError):
            pass
        finally:
            if conn is not None:
                conn.close() 

def execute_in_postgres(command, schema_name=None, database_name=None):
    """ create tables in the PostgreSQL database"""

    _params = params.copy()
    if database_name is not None:
        _params["dbname"] = database_name

    conn = psycopg2.connect(**_params)
    cur = conn.cursor()
    error = None

    if schema_name is not None:
        cur.execute(f"CREATE SCHEMA IF NOT EXISTS {schema_name};")
    print("\n\n -----------\n\n")
    print(command)
    print("\n\n -----------\n\n")
    try:
        cur.execute(command)
        cur.close()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as e:
        error = str(e)
        print(f"Error: {e}")
    finally:
        if conn is not None:
            conn.close()

    return error
 
def execute_in_sandbox_container(command):
    os.system(f"docker exec -it sandbox-postgres bash -c '{command}'")

def fix_missing_commas(sql_code):
    """
    INSERT INTO pe_1_hr.Personnel (military_id, rank, name, email, seniority, status, address) VALUES
    ('001278', 'lieutenant', 'Dario Dini', 'dario.dini@armymil.cou', '3', 'married', 'Milan'),
    ('872512', 'Major', 'Giulia Rossi', 'giulia.rossi@armymil.cou', '4', 'unmarried', 'Valencia'),
    ('252314', 'Captain', 'Roberto Bianchi', 'roberto.bianchi@armymil.cou', '1', 'divorced', 'Paris'),
    ('721361', 'Corporal', 'Alessia Verdi', 'alessia.verdi@armymil.cou', '3', 'unmarried', 'London'),
    ('012468', 'Lance Corporal', 'Antonio Galli', 'antonio.galli@armymil.cou', '3', 'married', 'Oslo'), 
    ('105893', 'Sergeant', 'Michele Viola', 'michele.viola@armymil.cou', '1','unmarried', 'Bratislav'),
    ('182541', 'Warrant Officer', 'Simone Neri', 'simone.neri@armymil.cou', '2', 'divorced', 'Moscow');

    INSERT INTO pe_1_hr.Training (course_name, period, max_attendees, location) VALUES
    ('sniper', 6, 12, 'Frankfurt'),
    ('artillerist', 4, 40, 'Barcelona'),
    ('driver', 2, 24, 'Graz'),
    ('observer', 3, 12, 'Prague'),
    ('cbrn', 1, 20, 'Budapest'),
    ('horseman', 5, 12, 'Krakow');    
    """
    lines = sql_code.split("\n")
    for i, line in enumerate(lines):
        if line.strip().startswith("("):
            if line[-1].strip().endswith(")"):
                lines[i] = line + ","
    return "\n".join(lines)


def remove_any_trailing_comma(sql_code):
    """
    CREATE TABLE IF NOT EXISTS Employee (
        employee_id SERIAL PRIMARY KEY,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        manager_id INT REFERENCES Employee(employee_id),
                                                    ^^^^^^ trailing comma
    );
    """
    lines = sql_code.split("\n")
    for i, line in enumerate(lines):
        if line.strip().endswith(");"):
            if lines[i-1].strip().endswith(","):
                lines[i-1] = lines[i-1][:-1]
    return "\n".join(lines)


def exclude_natural_language(input_text: str) -> str:
    sql_patterns = [
        'CREATE TABLE',
        'SERIAL',
        'INT',
        'VARCHAR',
        'DECIMAL',
        'DATE',
        'PRIMARY KEY',
        'FOREIGN KEY',
        'INSERT INTO',
        ');'
    ]
    nl_patterns = [
        "table",
        "To fix",
        "Here are",
        "Change",
        "This",
        "*",
        "Note"
    ]
    lines = input_text.split("\n")
    keep_lines = []
    for line in lines:
        if line.strip().startswith("("): # in case of insert statements
            keep_lines.append(line)
            continue
        if line=="":
            keep_lines.append("")
            continue
        nlp_patter_found = False
        for nlp in nl_patterns:
            if nlp in line:
                nlp_patter_found = True
                break
        if nlp_patter_found:
            continue
        for p in sql_patterns:
            if line.count(p) == 1:
                keep_lines.append(line)
                break

    sql = '\n'.join(keep_lines)
    return sql


def parse_script_filename(file_name):
    # example: "999_sql_cols_pe_1_schema_pe_1_hr.sh"
    db_name = file_name.split("sql_cols_")[1].split("_schema_")[0]
    schema_name = file_name.split("schema_")[1].split(".")[0]
    return db_name, schema_name

def extract_sql_code(script):
    """
    #!/bin/bash
    set -e
    psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    CREATE TABLE IF NOT EXISTS yyy.Weapon (
        weapon_id SERIAL PRIMARY KEY,
        type VARCHAR(255) NOT NULL,
        caliber VARCHAR(50) NOT NULL,
        accuracy INT,
        range INT);

    CREATE TABLE IF NOT EXISTS yyy.WeaponAccessory (
        accessory_id SERIAL PRIMARY KEY,
        weapon_id INT REFERENCES yyy.Weapon(weapon_id),
        type VARCHAR(50) NOT NULL);
    EOSQL

    Extract the SQL code between <<-EOSQL and EOSQL
    """
    with open(script, "r") as f:
        lines = f.readlines()
    sql_code = ""
    start = False
    for line in lines:
        if "<<-EOSQL" in line:
            start = True
            continue
        if "EOSQL" in line:
            break
        if start:
            sql_code += line
    return sql_code

def get_number_of_rows_for_schema(db_config, db_name, schema_name):
    for db in db_config["dbs"]:
        if db["name"] == db_name:
            for schema in db["schemas"]:
                if schema["name"] == schema_name:
                    return schema["nrows"]
    raise Exception(f"Could not find number of rows for {db_name}/{schema_name}")
