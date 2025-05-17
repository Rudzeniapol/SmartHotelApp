from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException

from app.auth.dependencies import get_current_user
from app.auth.schemas import UserSchema
from app.repository import queries

hotel_router = APIRouter()


@hotel_router.get("/me")
async def get_me(current_user: Annotated[UserSchema, Depends(get_current_user)]):
    return current_user


@hotel_router.get("/bookings")
async def get_bookings(current_user: Annotated[UserSchema, Depends(get_current_user)]):
    result = await queries.get_bookings(current_user.user_id)
    if result is None:
        return []
    return result


@hotel_router.post("/set_booking")
async def set_booking(current_user: Annotated[UserSchema, Depends(get_current_user)]):
    pass