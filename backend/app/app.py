from datetime import datetime
from typing import Union
from fastapi import FastAPI
import psycopg2
from pydantic import BaseModel

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


class NewsItem(BaseModel):
    name: str
    author: str
    website_link: str

    
def insert_news_item(news_item: NewsItem):
    """Inserts a new news item into the News table."""
    conn = connect()

    cursor = conn.cursor()

    # Get current timestamp
    current_time = datetime.now()

    # SQL query to insert news item
    query = """
        INSERT INTO News (name, date, author, website_link) 
        VALUES (%s, %s, %s, %s)
    """

    # Execute the query with data
    cursor.execute(query, (news_item.name, current_time, news_item.author, news_item.website_link))

    # Commit the transaction
    conn.commit()

    return {"message": "News item added successfully"}

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

app = FastAPI()

@app.get("/hello")
def read_root():
    return {"Hello": "World"}

@app.get("/news/{num}")
async def get_news(num: int):
    return get_latest_news(num)

@app.put("/add")
async def add_news(item: NewsItem):
    return insert_news_item(item)
