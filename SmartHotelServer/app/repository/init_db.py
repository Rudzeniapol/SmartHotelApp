import psycopg
from app.repository.core import get_db_connection
from app.config import DATABASE_URL


async def create_tables():
    commands = (
        """
        CREATE TYPE user_role AS ENUM (
            'guest',
            'admin'
        )
        """,

        """
        CREATE TABLE rooms
        (
            room_id      SERIAL PRIMARY KEY,
            is_available BOOLEAN            NOT NULL DEFAULT TRUE,
            floor        INTEGER            NOT NULL,
            number       VARCHAR(10) UNIQUE NOT NULL
        )
        """,

        """
        CREATE TABLE users
        (
            user_id     SERIAL PRIMARY KEY,
            phone      VARCHAR(20),
            name        VARCHAR(100)       NOT NULL,
            role        user_role          NOT NULL,
            room_id     INTEGER            REFERENCES rooms (room_id) ON DELETE SET NULL,
            hashed_pswd VARCHAR(255)       NOT NULL
        )
        """,

        """
        CREATE TABLE devices
        (
            device_id SERIAL PRIMARY KEY,
            room_id   INTEGER             NOT NULL REFERENCES rooms (room_id) ON DELETE CASCADE,
            BLE_token VARCHAR(255) UNIQUE NOT NULL,
            name      VARCHAR(100)        NOT NULL
        )
        """,
        """
        CREATE TABLE bookings
        (
            booking_id SERIAL PRIMARY KEY,
            room_id    INTEGER NOT NULL REFERENCES rooms (room_id) ON DELETE RESTRICT, -- Don't allow deleting a room if it has bookings. Or CASCADE if you want to delete bookings if room is deleted. RESTRICT is safer.
            user_id    INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,  -- If user is deleted, their bookings are also deleted.
            start_date DATE    NOT NULL,                                               -- The first day of the booking
            end_date   DATE    NOT NULL,                                               -- The day *after* the last night of stay (i.e., checkout date, booking is up to, but not including, this date)
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

            CONSTRAINT chk_dates CHECK (end_date > start_date)
        );
        """,
    )

    async with get_db_connection() as aconn:
        for command in commands:
            try:
                async with aconn.cursor() as acur:
                    await acur.execute(command)
                    await aconn.commit()
            except psycopg.errors.DuplicateTable:
                print(f"table {command.split()[2]} already exists")
                await aconn.rollback()
            except psycopg.errors.DuplicateObject:
                print(f"object {command.split()[2]} already exists")
                await aconn.rollback()
            except Exception as e:
                print(f"Error executing command: {e}")
                await aconn.rollback()
                raise
