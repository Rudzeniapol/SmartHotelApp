from datetime import datetime

from psycopg import rows

from app.repository.core import get_db_connection


async def get_user_by_phone(phone: str):
    async with get_db_connection() as conn:
        async with conn.cursor(row_factory=rows.dict_row) as cur:
            result = await cur.execute(
                """
                    SELECT user_id, phone, name, role, room_id, hashed_pswd FROM users
                    WHERE phone = %s
                """, [phone]
            )
            record = await cur.fetchone()
            return record


async def is_user_exist_by_phone(phone: str):
    async with get_db_connection() as conn:
        async with conn.cursor(row_factory=rows.dict_row) as cur:
            result = await cur.execute(
                """
                    SELECT user_id FROM users
                    WHERE phone = %s
                """, [phone]
            )
            record = await cur.fetchone()
            if record:
                return True
            return False


async def insert_user(number: str, name: str, role: str, room_id: str | None, hashed_pswd: str):
    async with get_db_connection() as conn:
        async with conn.cursor() as cur:
            await cur.execute(
            """
                INSERT INTO users (phone, name, role, room_id, hashed_pswd)
                VALUES (%s, %s, %s, %s, %s)
            """,
             [number, name, role, room_id, hashed_pswd])
        await conn.commit()


async def insert_booking(room_id: int, user_id: int, start_date: datetime, end_date: datetime):
    async with get_db_connection() as conn:
        async with conn.cursor() as cur:
            await cur.execute(
            """
                INSERT INTO bookings (room_id, user_id, start_date, end_date)
                VALUES (%s, %s, %s, %s)
            """,
             [room_id, user_id, start_date, end_date])
        await conn.commit()


async def get_bookings(user_id: int):
    async with get_db_connection() as conn:
        async with conn.cursor(row_factory=rows.dict_row) as cur:
            await cur.execute(
            """
                SELECT * FROM bookings
                WHERE user_id = %s
            """,
             [user_id])
            records = await cur.fetchall()
            if records:
                return records
            return None

""" CONFLICTING BOOKINGS:
    SELECT booking_id -- Select anything, we just care if rows are returned
    FROM bookings
    WHERE
        room_id = :target_room_id                          -- For the specific room
        AND start_date < :desired_end_date                 -- Existing booking starts before the desired period ends
        AND end_date > :desired_start_date;                -- Existing booking ends after the desired period begins
"""