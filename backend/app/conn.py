import psycopg2


def connect():
    try:
        conn = psycopg2.connect(
            dbname="database",
            user="user",
            password="password",
            host="postgres",  # This should match the service name in docker-compose.yml
            port="5432"
        )
        return conn
    except Exception as e:
        print(f"I am unable to connect to the database {e}")
        return None
