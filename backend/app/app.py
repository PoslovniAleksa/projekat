from datetime import datetime
from typing import Union
from fastapi import FastAPI, HTTPException, Query, HTTPException, Depends, status
import psycopg2
from pydantic import BaseModel
from conn import *
from user import *
from search import search_news
from comments import get_comments

from datetime import datetime, timedelta
from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from passlib.context import CryptContext
from jose import JWTError, jwt

from fastapi.middleware.cors import CORSMiddleware
# List of allowed origins (domains)
origins = [
    "http://localhost:8080",  # Replace with your frontend URL
    "https://localhost:8080",  # If you use HTTPS for your frontendm
    "http://localhost",
    "*"
]

class NewsItem(BaseModel):
    name: str
    author: str
    website_link: str

class Comment(BaseModel):
    comment_text: str
    news_id: int
    
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

    conn.close()
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
    conn.close()
    return news_list


PAGE_SIZE = 20

def get_page_news(page: int):
    offset = (page - 1) * PAGE_SIZE
    conn = connect()

    # SQL query to fetch latest news
    query = """
        SELECT name, date, author, website_link, id
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
                name, date, author, website_link, id = row
                news_list.append({
                    "name": name,
                    "date": date.strftime('%Y-%m-%d %H:%M:%S'),  # Format date as string
                    "author": author,
                    "website_link": website_link,
                    "id": id 
                })
            return news_list
        
    except psycopg2.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {e}")
    finally:
        conn.close()


def insert_comment(comment: Comment, user_id: int):
    """Inserts a new comment"""
    
    try:
        conn = connect()
        cursor = conn.cursor()

        # Check if page exist
        check_query = """
        SELECT EXISTS (SELECT 1 FROM News WHERE id = %s);
        """
        cursor.execute(check_query, (comment.news_id, ))
        check_res = cursor.fetchone()
        if not check_res[0]:
            raise HTTPException(status_code=404, detail="News with provided ID can not be found")

        # Get current timestamp
        current_time = datetime.now()

        # SQL query to insert news item
        query = """
            INSERT INTO Comments (user_id, news_id, comment_date, comment_text) 
            VALUES (%s, %s, %s, %s)
        """
        # Execute the query with data
        cursor.execute(query, (user_id, comment.news_id, current_time, comment.comment_text))
        # Commit the transaction
        conn.commit()
        return {"message": "Comment added successfully"}
    
    except psycopg2.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {e}")
    finally:
        conn.close()


app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/hello")
def read_root():
    return {"Hello": "World"}

# @app.get("/news/{num}")
# async def get_news(num: int):
#     return get_latest_news(num)

@app.put("/add-news")
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


# User registration endpoint
@app.get("/search/{keyword}")
async def search(keyword: str):
    return search_news(keyword)


@app.get("/comments/{news_id}")
async def comments(news_id: int):
    return get_comments(news_id)

@app.put("/add-comment")
async def add_comment(comment: Comment, current_user: User = Depends(get_current_user)):
    return insert_comment(comment, current_user.id)
