from typing import Union

from fastapi import FastAPI

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

app = FastAPI()


def get_latest_news(num_news=5):
    """Fetches the latest news articles from the News table."""
    conn = connect()
    cursor = conn.cursor()

    # SQL query to fetch latest news
    query = """
        SELECT name, date, author, website_link
        FROM News
        ORDER BY date DESC
        LIMIT %s
    """
    cursor.execute(query, (num_news,))
    news_rows = cursor.fetchall()

     # Prepare list of dictionaries for JSON response
    news_list = []
    for row in news_rows:
        name, date, author, website_link = row
        news_list.append({
            "name": name,
            "date": date.strftime('%Y-%m-%d %H:%M:%S'),  # Format date as string
            "author": author,
            "website_link": website_link
        })

    return news_list
    # Closing database connection.
    if conn:
        cursor.close()
        conn.close()

@app.get("/hello")
def read_root():
    return {"Hello": "World"}
from fastapi import FastAPI

app = FastAPI()


@app.get("/news/{num}")
async def get_news(num: int):
    return get_latest_news(num)
