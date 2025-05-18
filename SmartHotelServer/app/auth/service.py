import hashlib
from datetime import datetime, timedelta, timezone

from fastapi import Depends, FastAPI, HTTPException, status
from psycopg.errors import UniqueViolation
import jwt

from app.repository import queries
from app.auth.schemas import UserRegistrationFormSchema, UserLoginFormSchema, LoginInfoSchema
from app.config import ALGORITHM, JWT_SECRET, JWT_EXPIRE_MINUTES


def verify_password(plain_password: str, hashed_password: str) -> bool:
    if hashlib.sha256(plain_password.encode()).hexdigest() == hashed_password:
        return True
    return False


def create_jwt(data: dict, expires_delta: timedelta, secret: str) -> str:
    to_encode = data.copy()
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, secret, algorithm=ALGORITHM)


def create_access_token(data: dict) -> str:
    return create_jwt(data, timedelta(minutes=JWT_EXPIRE_MINUTES), JWT_SECRET)


def decode_access_token(token: str) -> dict:
    return dict(jwt.decode(token, JWT_SECRET, algorithms=[ALGORITHM]))


async def get_user_by_phone(phone: str):
    user = await queries.get_user_by_phone(phone)
    if user:
        return user
    return None


async def authenticate_user(user_data: UserLoginFormSchema) -> LoginInfoSchema | None:
    user = await queries.get_user_by_phone(user_data.phone)
    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='User does not exist')
    if not verify_password(user_data.password, user["hashed_pswd"]):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='incorrect password')
    access_token = create_access_token({
        "sub": user_data.phone,
        "type": "access",
    })
    user.update({"token": access_token})
    return LoginInfoSchema(**user)


async def is_user_exist(phone: str):
    result = await queries.is_user_exist_by_phone(phone)
    return result


async def register_user(user: UserRegistrationFormSchema, role='guest'):
    hashed_password = hashlib.sha256(user.password.encode()).hexdigest()
    try:
        await queries.insert_user(user.phone, user.name, role, None, hashed_password)
        return True
    except UniqueViolation as e:
        raise HTTPException(status_code=400, detail="User already exists")