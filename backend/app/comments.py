from fastapi import FastAPI, HTTPException, Depends, status, Query
import psycopg2
from psycopg2 import sql

from conn import connect


def get_comments(news_id: int):
    conn = connect()
    cursor = conn.cursor()

    # SQL query to search for substrings in each column
    query = """
        SELECT c.comment_text, c.comment_date, u.username
        FROM Comments c
        JOIN Users u ON c.user_id = u.id
        WHERE c.news_id = %s;

    """
    cursor.execute(query, (news_id,))
    rows = cursor.fetchall()
    
    res = []
    for row in rows:
        comment_text, comment_date, username = row
        res.append({
            "comment_text": comment_text,
            "comment_date": comment_date,
            "username": username
        })

    conn.close()
    return res