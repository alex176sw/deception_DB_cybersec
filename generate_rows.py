import os
from pathlib import Path
import yaml
import argparse
from tqdm import tqdm

from loguru import logger
from table_generator import TableGenerator
logger.add("gen_tables_{time}.log")

from utils import (
    check_db_connection,
    clean_postgres,
    extract_sql_code,
    parse_script_filename,
    write_psql_script,
    POSTGRES_SCRIPTS_PATH,
    execute_in_sandbox_container,
    start_postgres_sandbox_container
)

def cli():
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--db-config", type=str, required=False, default="./image_configuration/user_configurations/dbs.yaml")
    parser.add_argument("-s", "--schema-dir", type=str, required=False, default="./image_configuration/postgres_initialization")
    parser.add_argument("-m", "--max-attempts", type=int, required=False, default=8)
    parser.add_argument("-i", "--iterations", type=int, required=False, default=2)
    args = parser.parse_args()
    main(args)

def main(args):
    with open(args.db_config, "r", encoding="utf-8") as cf:
        db_config = yaml.load(cf, Loader=yaml.Loader)

    if not check_db_connection():
        raise Exception("Connection to Postgres is not established")

    schema_sql_scripts = [Path(args.schema_dir) / s for s in os.listdir(args.schema_dir) if "999_sql_cols" in s]
    db_and_schema_names = [parse_script_filename(str(s)) for s in schema_sql_scripts]

    db_names = [s[0] for s in db_and_schema_names]
    schema_names = [s[1] for s in db_and_schema_names]

    table_gen = TableGenerator(max_attempts=args.max_attempts)

    scripts = []
    for db_name, schema_name, script in tqdm(zip(db_names, schema_names, schema_sql_scripts)):
        
        for i in range(args.iterations):

            output_file = Path(f"{POSTGRES_SCRIPTS_PATH}/999_sql_rows_{db_name}_schema_{schema_name}_{i}.sh")

            logger.info(f"Starting iteration {i} for {db_name}/{schema_name}")

            table_schema_sql = extract_sql_code(str(script))
            
            table_rows_sql = table_gen.generate_table_rows(table_schema_sql, schema_name, db_name)

            if table_rows_sql:
                logger.info(f"Successfully generated SQL for {db_name}/{schema_name}")
                write_psql_script(
                    output_file=output_file,
                    db_name=db_name,
                    execute_as_user="postgres", # TODO: execute as owner
                    content=table_rows_sql
                )
                logger.info(f"Schema script written to {output_file}")
                scripts.append(output_file)

# "    clean_postgres(schema_names)
#     for script in scripts:
#         logger.info(f"Executing {script}")
#         with open(script, "r") as f:
#             content = f.read()
#             execute_in_sandbox_container(content)
         
if __name__=='__main__':
    cli()