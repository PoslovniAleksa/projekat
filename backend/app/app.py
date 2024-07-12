from datetime import datetime
from typing import Union
from fastapi import FastAPI, HTTPException, Query, HTTPException, Depends, status
import psycopg2
from pydantic import BaseModel
from conn import *;
from user import *;

from datetime import datetime, timedelta
from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from passlib.context import CryptContext
from jose import JWTError, jwt

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


PAGE_SIZE = 10

def get_page_news(page: int):
    offset = (page - 1) * PAGE_SIZE
    conn = connect()

    # SQL query to fetch latest news
    query = """
        SELECT name, date, author, website_link
        FROM News
        ORDER BY date DESC
        LIMIT %s
        OFFSET %s
    """

    try:
        with conn.cursor() as cur:
            cur.execute(query, (PAGE_SIZE, offset))
            rows = cur.fetchall()
            # Prepare list of dictionaries for JSON response
            news_list = []
            for row in rows:
                name, date, author, website_link = row
                news_list.append({
                    "name": name,
                    "date": date.strftime('%Y-%m-%d %H:%M:%S'),  # Format date as string
                    "author": author,
                    "website_link": website_link
                })
            return news_list
        
    except psycopg2.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {e}")
    finally:
        conn.close()


app = FastAPI()

@app.get("/hello")
def read_root():
    return {"Hello": "World"}

# @app.get("/news/{num}")
# async def get_news(num: int):
#     return get_latest_news(num)

@app.put("/add")
async def add_news(item: NewsItem, current_user: User = Depends(get_current_user)):
    return insert_news_item(item)

@app.get("/news/")
async def get_news(page: int = Query(1, ge=1)):
    return get_page_news(page)

# Endpoint to get token
@app.post("/login")
@app.post("/token")
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid username or password")
    access_token = create_access_token(data={"sub": user.username})
    return {"access_token": access_token, "token_type": "bearer"}

# Example protected route
@app.get("/protected-route/")
async def protected_route(current_user: User = Depends(get_current_user)):
    return {"message": "This is a protected route"}

# User registration endpoint
@app.post("/register")
async def register_user(user: UserCreate):
    hashed_password = pwd_context.hash(user.password)
    query = "INSERT INTO Users (username, password_hash) VALUES (%s, %s) RETURNING id;"
    values = (user.username, hashed_password)

    # Check if username already exists
    query_check = "SELECT id FROM Users WHERE username = %s;"
    values_check = (user.username,)

    try:
        conn = connect()
        with conn.cursor() as cur:

            cur.execute(query_check, values_check)
            existing_user = cur.fetchone()
            if existing_user:
                raise HTTPException(status_code=400, detail="Username already registered")

            cur.execute(query, values)
            user_id = cur.fetchone()[0]
            conn.commit()
            return {"id": user_id, "username": user.username}
    except psycopg2.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {e}")
    finally:
        conn.close()