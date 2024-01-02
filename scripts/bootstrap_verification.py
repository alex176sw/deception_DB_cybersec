import yaml
import argparse
import psycopg2

def cli():
    parser = argparse.ArgumentParser()
    parser.add_argument("-dbc", "--db-config", type=str, required=False, default="../user_configurations/dbs.yaml")
    parser.add_argument("-urc", "--users-roles-config", type=str, required=False, default="../user_configurations/users_and_roles.yaml")
    parser.add_argument("-ip",  "--ip", type=str, required=False, default="localhost")
    parser.add_argument("-p",   "--port", type=str, required=False, default="5432")
    args = parser.parse_args()
    main(args)

def get_username_and_password_of_role(role: str, users_roles_config: dict):
    for user in users_roles_config["users"]:
        if user["role"] == role:
            return user["name"], user["password"]
    return None, None

def connect(host, port, dbname, username, password):
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # connect to the PostgreSQL server
        conn = psycopg2.connect(
            host=host,
            port=port,
            database=dbname,
            user=username,
            password=password
        )		
        # create a cursor
        cur = conn.cursor()
        cur.execute('SELECT version()')
        _ = cur.fetchone()
        # close the communication with the PostgreSQL
        cur.close()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        raise error

    return conn

def select_table_names_in_schema(conn, schema_name):
    cur = conn.cursor()
    cur.execute(f"SELECT table_name FROM information_schema.tables WHERE table_schema = '{schema_name}'")
    table_names = [row[0] for row in cur.fetchall()]
    cur.close()
    return table_names

def main(args):
    with open(args.db_config, "r", encoding="utf-8") as cf:
        db_config = yaml.load(cf, Loader=yaml.Loader)

    with open(args.users_roles_config, "r", encoding="utf-8") as cf:
        users_roles_config = yaml.load(cf, Loader=yaml.Loader)


    for db in db_config["dbs"]:
        owner_role = db['owner']
        username, password = get_username_and_password_of_role(owner_role, users_roles_config)
        print(f"Connecting to {db['name']} as {username} with role {owner_role} with password {password}..")
        conn = connect(args.ip, args.port, db['name'], username, password)
        for schema_name in db["schemas"]:
            print(f"Selecting table names in schema {schema_name}..")
            table_names = select_table_names_in_schema(conn, "")
        conn.close()
        print("Ok!")

    # test grant_read_access_to
    for db in db_config["dbs"]:
        for role in db["grant_read_access_to"]:
            username, password = get_username_and_password_of_role(role, users_roles_config)
            if username and password:
                print(f"Connecting to {db['name']} as {username} with role {role} with password {password}..")
                conn = connect(args.ip, args.port, db['name'], username, password)
                for schema_name in db["schemas"]:
                    print(f"Selecting table names in schema {schema_name}..")
                    table_names = select_table_names_in_schema(conn, "")
                conn.close()
                print("Ok!")


if __name__=='__main__':
    cli()