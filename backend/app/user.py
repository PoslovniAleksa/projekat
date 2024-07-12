from datetime import datetime, timedelta
from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from passlib.context import CryptContext
from jose import JWTError, jwt
from pydantic import BaseModel

from conn import connect

# User model
class User:
    def __init__(self, id: int, username: str, password_hash: str):
        self.id = id
        self.username = username
        self.password_hash = password_hash

# for user register
class UserCreate(BaseModel):
    username: str
    password: str


# JWT settings
SECRET_KEY = "tajna-sifra"  # Change this to a secure value
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# OAuth2 scheme for token
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Function to verify password
def verify_password(plain_password: str, hashed_password: str):
    return pwd_context.verify(plain_password, hashed_password)

# Function to get user by username
def get_user(username: str):
    conn = connect()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT id, username, password_hash FROM Users WHERE username = %s", (username,))
            user_data = cur.fetchone()
            if user_data:
                return User(id=user_data[0], username=user_data[1], password_hash=user_data[2])
    finally:
        conn.close()

# Function to authenticate user
def authenticate_user(username: str, password: str):
    user = get_user(username)
    if not user or not verify_password(password, user.password_hash):
        return None
    return user
    ...

# Function to create access token
def create_access_token(data: dict):
    to_encode = data.copy()
    access_token_expires = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": access_token_expires})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

# Dependency to get current user from token
async def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")
    user = get_user(username)
    if user is None:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="User not found")
    return user
