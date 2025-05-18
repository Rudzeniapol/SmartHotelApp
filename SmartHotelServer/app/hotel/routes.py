from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, Body, status
from fastapi.responses import JSONResponse

from app.auth.dependencies import get_current_user
from app.admin.dependencies import get_current_admin
from app.auth.schemas import UserSchema
from app.hotel.schemas import BookingSchema, SetBookingSchema
from app.repository import queries
from app.hotel import service

hotel_router = APIRouter()


@hotel_router.get("/me")
async def get_me(current_user: Annotated[UserSchema, Depends(get_current_user)]):
    return current_user


@hotel_router.get("/rooms")
async def get_rooms(current_user: Annotated[UserSchema, Depends(get_current_user)]):
    result = await queries.get_rooms()
    if result is None:
        return []
    return result


@hotel_router.get("/bookings")
async def get_bookings(current_user: Annotated[UserSchema, Depends(get_current_user)]):
    result = await queries.get_bookings(current_user.user_id)
    if result is None:
        return []
    bookings = []
    for record in result:
        print(record)
        bookings.append(BookingSchema(**record))
    return bookings


@hotel_router.post("/bookings")
async def set_booking(current_user: Annotated[UserSchema, Depends(get_current_user)],
                      booking: Annotated[SetBookingSchema, Body()]):
    print('____________________________________________________________________')
    print(current_user)
    print('____________________________________________________________________')
    print(booking)
    print('____________________________________________________________________')
    if await service.set_booking(current_user.user_id, booking):
        return JSONResponse({'message': 'booking is registered!'}, status.HTTP_201_CREATED)
    return HTTPException(status_code=400, detail="Booking is unavailable")


@hotel_router.get("/all_bookings", tags=["admin"])
async def get_bookings(current_user: Annotated[UserSchema, Depends(get_current_admin)]):
    result = await queries.get_all_bookings()
    if result is None:
        return []
    bookings = []
    for record in result:
        bookings.append(BookingSchema(**record))
    return bookings


@hotel_router.get("/all_rooms", tags=["admin"])
async def get_bookings(current_user: Annotated[UserSchema, Depends(get_current_admin)]):
    result = await queries.get_rooms()
    if result is None:
        return None
    return result