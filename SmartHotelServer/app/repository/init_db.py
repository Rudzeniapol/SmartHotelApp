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
        """
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
