from fastapi import FastAPI, HTTPException, Depends, status, Query
import psycopg2
from psycopg2 import sql

from conn import connect

def search_news(keyword: str):
    conn = connect()
    cursor = conn.cursor()

    # SQL query to search for substrings in each column
    search_query = """
        SELECT *
        FROM News
        WHERE name ILIKE %s 
        OR author ILIKE %s
        OR website_link ILIKE %s;
    """

    # Format the search string with '%' wildcard

    # Execute the query with parameters
    formated_keyword = '%' + keyword + '%'
    cursor.execute(search_query, (formated_keyword, formated_keyword, formated_keyword))
    results = cursor.fetchall()
    
    news_list = []
    for row in results:
        _, name, date, author, website_link = row
        news_list.append({
            "name": name,
            "date": date.strftime('%Y-%m-%d %H:%M:%S'),  # Format date as string
            "author": author,
            "website_link": website_link
        })
    return news_list 
