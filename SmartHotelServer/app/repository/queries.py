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