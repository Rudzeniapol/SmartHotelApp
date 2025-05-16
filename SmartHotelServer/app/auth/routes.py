from typing import Annotated, Union

from fastapi import APIRouter, Body, HTTPException

from app.auth.schemas import TokenSchema, UserLoginFormSchema, UserRegistrationFormSchema

auth_router = APIRouter()


@auth_router.post("/login")
async def login(user_data: Annotated[UserLoginFormSchema, Body()]):
    if user_data.password == '12345678':
        return TokenSchema(access_token='LKFJDSLFKALDKf', token_type='Bearer')
    raise HTTPException(status_code=401, detail="Invalid credentials")

@auth_router.post("/register")
async def login(user_data: Annotated[UserRegistrationFormSchema, Body()]):
    if user_data.password == '12345678':
        return TokenSchema(access_token='LKFJDSLFKALDKf', token_type='Bearer')
    raise HTTPException(status_code=401, detail="Invalid credentials")