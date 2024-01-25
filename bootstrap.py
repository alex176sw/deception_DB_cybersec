

import os
import re
import yaml
import argparse
from utils import execute_in_sandbox_container, start_psql_query, close_psql_query

from utils import POSTGRES_SCRIPTS_PATH, CONF_PATH, POSTGRES_TEMPLATE, HBA_TEMPLATE

def cli():
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--postgres-config", type=str, required=False, default="./image_configuration/user_configurations/postgres.yaml")
    parser.add_argument("-d", "--db-config", type=str, required=False, default="./image_configuration/user_configurations/dbs.yaml")
    parser.add_argument("-u", "--users-roles-config", type=str, required=False, default="./image_configuration/user_configurations/users_and_roles.yaml")
    args = parser.parse_args()
    main(args)


def create_roles(config: dict, file_name_idx):
    psql_cmd_string = start_psql_query()
    for super_role, sub_roles in config["roles"].items():
        psql_cmd_string += f"\tCREATE ROLE {super_role} WITH CREATEDB;\n"
        for role in sub_roles:
            psql_cmd_string += f"\tCREATE ROLE {role} WITH LOGIN;\n"
    psql_cmd_string += close_psql_query()
    with open(f"{POSTGRES_SCRIPTS_PATH}/{str(file_name_idx).zfill(4)}_init-roles.sh", "w") as f:
        f.write(psql_cmd_string)
    print("Write role scripts")

def create_users(config: dict, file_name_idx):
    psql_cmd_string = start_psql_query()
    for user in config["users"]:
        psql_cmd_string += f"\tCREATE ROLE {user['name']};\n"
        psql_cmd_string += f"\tGRANT       {user['role']} TO {user['name']};\n"
        psql_cmd_string += f"\tALTER ROLE  {user['name']} WITH LOGIN PASSWORD '{user['password']}';\n"
    psql_cmd_string += close_psql_query()
    with open(f"{POSTGRES_SCRIPTS_PATH}/{str(file_name_idx).zfill(4)}_init-users.sh", "w") as f:
        f.write(psql_cmd_string)
    print("Write user scripts")

def create_hba_authentication(user_roles_config: dict, dbs_config: dict):
    with open(HBA_TEMPLATE, 'r') as template_file:
        template_content = template_file.read()

    for db in dbs_config["dbs"]:
        db_name = db["name"]
        roles = set()
        for role in db["grant_read_access_to"]:
            roles.add(role)
        for role in db["grant_write_access_to"]:
            roles.add(role)
        for role in db["grant_update_access_to"]:
            roles.add(role)
        for role in db["grant_delete_access_to"]:
            roles.add(role)
        roles.add(db["owner"])

        user_names_per_role = dict()
        for user in user_roles_config["users"]:
            if user["role"] not in user_names_per_role:
                user_names_per_role[user["role"]] = set()
            user_names_per_role[user["role"]].add(user["name"])
        #print(user_names_per_role)

        for role in roles:
            if role in user_names_per_role:
                for user_name in user_names_per_role[role]:
                    for connection in db["connections"]:
                        if connection == "local":
                            template_content += f"\n{connection.ljust(10)}\t{db_name}\t{user_name}\t{''.rjust(25)}\t{db['auth']}"
                        else:
                            #template_content += f"\n{connection.ljust(10)}\t{db_name}\t{user_name}\t{'127.0.0.1/32'.rjust(25)}\t{db['auth']}"
                            #template_content += f"\n{connection.ljust(10)}\t{db_name}\t{user_name}\t{'::1/128'.rjust(25)}\t{db['auth']}"
                            template_content += f"\n{connection.ljust(10)}\t{db_name}\t{user_name}\t{'samenet'.rjust(25)}\t{db['auth']}"

    with open(f"{CONF_PATH}/pg_hba.conf", 'w') as output_file:
        output_file.write(template_content)
    print("Write pg_hba.conf")

def get_grant_db_privileges(user_name: str, granted_dbs: list[str]):
    pqsl_cmd = ""
    for granted_db in granted_dbs:
        pqsl_cmd += f"\tGRANT ALL PRIVILEGES ON DATABASE {granted_db['db_name']} TO {user_name};\n"
        pqsl_cmd += f"\tGRANT ALL ON SCHEMA public TO {user_name};\n"
        pqsl_cmd += f"\tGRANT USAGE ON SCHEMA public TO {user_name};\n"
    return pqsl_cmd

def create_dbs(dbs_config: dict, file_name_idx):
    for i, db in enumerate(dbs_config["dbs"]):
        psql_cmd_string = start_psql_query()
        psql_cmd_string += f"\tCREATE DATABASE {db['name']} WITH OWNER {db['owner']};\n"
        psql_cmd_string += close_psql_query()
        with open(f"{POSTGRES_SCRIPTS_PATH}/{str(file_name_idx+i).zfill(4)}_init-db-{db['name']}.sh", "w", encoding="utf-8") as f:
            f.write(psql_cmd_string)
        print("Write db scripts for ", db["name"])

def create_schemas(dbs_config: dict, file_name_idx):
    for i, db in enumerate(dbs_config["dbs"]):
        psql_cmd_string = start_psql_query(db_name=db["name"])
        for schema in db["schemas"]:
            psql_cmd_string += f"\tCREATE SCHEMA IF NOT EXISTS {schema['name']};\n"
        psql_cmd_string += close_psql_query()
        with open(f"{POSTGRES_SCRIPTS_PATH}/{str(file_name_idx+i).zfill(4)}_init-schemas-{db['name']}.sh", "w", encoding="utf-8") as f:
            f.write(psql_cmd_string)
        print("Write schema scripts for ", db["name"])

def grant_authorization_to_roles(dbs_config: dict, file_name_idx):
    for i, db in enumerate(dbs_config["dbs"]):
        # this should be executed as j* users but I don't know ho to provide the password
        psql_cmd_string = start_psql_query(execute_as_user="postgres", db_name=db["name"])
        schemas = [schema["name"] for schema in db["schemas"]]+["public"]
        for schema in schemas:
            for role in db["grant_read_access_to"]:
                psql_cmd_string += f"\tGRANT SELECT ON ALL TABLES IN SCHEMA {schema} TO {role};\n"
                psql_cmd_string += f"\tGRANT ALL ON SCHEMA {schema} TO {db['owner']};\n"
            for role in db["grant_write_access_to"]:
                psql_cmd_string += f"\tGRANT INSERT ON ALL TABLES IN SCHEMA {schema} TO {role};\n"
                psql_cmd_string += f"\tGRANT ALL ON SCHEMA {schema} TO {db['owner']};\n"
            for role in db["grant_update_access_to"]:
                psql_cmd_string += f"\tGRANT UPDATE ON ALL TABLES IN SCHEMA {schema} TO {role};\n"
                psql_cmd_string += f"\tGRANT ALL ON SCHEMA {schema} TO {db['owner']};\n"
            for role in db["grant_delete_access_to"]:
                psql_cmd_string += f"\tGRANT DELETE ON ALL TABLES IN SCHEMA {schema} TO {role};\n"
                psql_cmd_string += f"\tGRANT ALL ON SCHEMA {schema} TO {db['owner']};\n"
        psql_cmd_string += close_psql_query()
        with open(f"{POSTGRES_SCRIPTS_PATH}/{str(file_name_idx+i).zfill(4)}_init-authorization-{db['name']}.sh", "w", encoding="utf-8") as f:
            f.write(psql_cmd_string)
        print("Write authorization scripts for", db["name"])

def create_postgres_config(config: dict):
    with open(POSTGRES_TEMPLATE, 'r', encoding='utf-8') as template_file:
        template_content = template_file.read()

    for placeholder, value in config["pg_config"].items():
        placeholder_pattern = re.compile(rf'@{re.escape(placeholder.upper())}@')
        if isinstance(value, int):
            template_content = placeholder_pattern.sub(f"{value}", f"{template_content}")
        else:
            template_content = placeholder_pattern.sub(f"'{value}'", f"{template_content}")

    with open(f"{CONF_PATH}/postgres.conf", 'w', encoding='utf-8') as output_file:
        output_file.write(template_content)
    print("Write postgres.conf")


def main(args):

    with open(args.db_config, "r", encoding="utf-8") as cf:
        db_config = yaml.load(cf, Loader=yaml.Loader)

    with open(args.users_roles_config, "r", encoding="utf-8") as cf:
        users_roles_config = yaml.load(cf, Loader=yaml.Loader)

    with open(args.postgres_config, "r", encoding="utf-8") as cf:
        pg_config = yaml.load(cf, Loader=yaml.Loader)

    create_postgres_config(pg_config)
    create_hba_authentication(users_roles_config, db_config)
    create_roles(users_roles_config, file_name_idx=0)
    create_users(users_roles_config, file_name_idx=1)
    create_dbs(db_config, file_name_idx=2)
    n_dbs = len(db_config["dbs"])
    create_schemas(db_config, file_name_idx=3+n_dbs)
    grant_authorization_to_roles(db_config, file_name_idx=4+n_dbs)

    scripts = sorted([os.path.join(POSTGRES_SCRIPTS_PATH, s) for s in os.listdir(POSTGRES_SCRIPTS_PATH) if ".sh" in s] )
    print(scripts)
    for script in scripts:
        print(f"Executing {script}")
        with open(script, "r") as f:
            content = f.read()
            execute_in_sandbox_container(content)
        

if __name__=='__main__':
    cli()
