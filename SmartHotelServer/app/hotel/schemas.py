from typing import Annotated
from datetime import datetime
from pydantic import BaseModel, Field


class SetBookingSchema(BaseModel):
    number: Annotated[str, Field(alias="roomNumber")]
    check_in: Annotated[datetime, Field(alias="checkIn")]
    check_out: Annotated[datetime, Field(alias="checkOut")]


class BookingSchema(BaseModel):
    booking_id: Annotated[int, Field()]
    room_id: Annotated[int, Field()]
    check_in: Annotated[datetime, Field()]
    check_out: Annotated[datetime, Field()]
    is_checked_in: Annotated[bool, Field()]
    is_checked_out: Annotated[bool, Field()]
