from typing import Annotated, Union

from fastapi import APIRouter, Body, HTTPException, Response, Response
from fastapi.responses import JSONResponse
from starlette import status

from app.auth.schemas import TokenSchema, UserLoginFormSchema, UserRegistrationFormSchema, LoginInfoSchema

from app.auth import service

auth_router = APIRouter()


@auth_router.post("/login")
async def login(user_data: Annotated[UserLoginFormSchema, Body()]):
    result = await service.authenticate_user(user_data)
    return JSONResponse(dict(result), status.HTTP_200_OK)


@auth_router.post("/register")
async def register(user_data: Annotated[UserRegistrationFormSchema, Body()]):
    if await service.is_user_exist(user_data.phone):
        raise HTTPException(status_code=400, detail="User already exists")
    if await service.register_user(user_data):
        return JSONResponse({'message': 'user is registered!'}, status.HTTP_201_CREATED)