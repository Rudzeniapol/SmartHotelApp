from typing import Annotated

from fastapi import APIRouter, Body, HTTPException, status
from fastapi.responses import JSONResponse

from app.auth.schemas import UserRegistrationFormSchema
from app.auth import service as auth_service
from app.config import SUPERUSER_PASSWORD

admin_router = APIRouter()

@admin_router.get("/")
async def healthcheck():
    return {"status": "ok"}


@admin_router.post("/register")
async def register(user_data: Annotated[UserRegistrationFormSchema, Body()],
                   superuser_password: str):
    if superuser_password != SUPERUSER_PASSWORD:
        return HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Incorrect superuser password")
    if await auth_service.is_user_exist(user_data.phone):
        raise HTTPException(status_code=400, detail="User already exists")
    if await auth_service.register_user(user_data, role='admin'):
        return JSONResponse({'message': 'admin is registered!'}, status.HTTP_201_CREATED)