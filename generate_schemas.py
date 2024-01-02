import yaml
import argparse
from tqdm import tqdm

from loguru import logger
logger.add("gen_tables_{time}.log")

from utils import (
    check_db_connection,
    clean_postgres,
    write_psql_script,
    POSTGRES_SCRIPTS_PATH
)
from table_generator import TableGenerator
    

def cli():
    parser = argparse.ArgumentParser()
    
    parser.add_argument("-d", "--db-config", type=str, required=False, default="./image_configuration/user_configurations/dbs.yaml")
    parser.add_argument("-u", "--users-roles-config", type=str, required=False, default="./image_configuration/user_configurations/users_and_roles.yaml")
    parser.add_argument("-m", "--max-attempts", type=int, required=False, default=8)
    parser.add_argument("-c", "--clean-postgres", type=int, required=False, default=1)

    args = parser.parse_args()
    main(args)

def main(args):
    with open(args.db_config, "r", encoding="utf-8") as cf:
        db_config = yaml.load(cf, Loader=yaml.Loader)

    with open(args.users_roles_config, "r", encoding="utf-8") as cf:
        users_roles_config = yaml.load(cf, Loader=yaml.Loader)

    if not check_db_connection():
        raise Exception("Connection to Postgres is not established")

    schema_names = []
    for db in tqdm(db_config["dbs"]):
        for schema in db["schemas"]:
            schema_names.append(schema["name"])

    if args.clean_postgres == 1:
        clean_postgres(schema_names)

    table_gen = TableGenerator(args.max_attempts)

    for db in tqdm(db_config["dbs"]):
        for schema in db["schemas"]:
            table_schema_code = table_gen.generate_table_schema(schema["number_of_tables"], schema["subject"], schema["name"])
            if table_schema_code:
                logger.info(f"Successfully generated SQL for {schema['subject']} with {schema['number_of_tables']} tables")
                output_file = f"{POSTGRES_SCRIPTS_PATH}/999_sql_cols_{db['name']}_schema_{schema['name']}.sh"
                write_psql_script(
                    output_file=output_file,
                    db_name=db["name"],
                    execute_as_user="postgres", # TODO: execute as owner
                    content=table_schema_code
                )
                logger.info(f"Schema script written to {output_file}")


if __name__=='__main__':
    cli()