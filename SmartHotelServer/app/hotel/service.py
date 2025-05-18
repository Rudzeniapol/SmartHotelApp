from fastapi import HTTPException

from app.hotel.schemas import SetBookingSchema, BookingSchema
from app.repository.queries import insert_booking, get_room_by_number, is_conflicting_booking


async def set_booking(user_id: int, booking: SetBookingSchema) -> bool:
    room = await get_room_by_number(booking.number)
    if room:
        if not await is_conflicting_booking(room["room_id"], booking.check_in, booking.check_out):
            await insert_booking(room["room_id"], user_id, booking.check_in, booking.check_out)
            return True
    return False
