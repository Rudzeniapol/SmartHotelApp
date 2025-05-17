from contextlib import asynccontextmanager
from psycopg import AsyncConnection
from app.config import DATABASE_URL


@asynccontextmanager
async def get_db_connection():
    conn = None
    try:
        conn = await AsyncConnection.connect(DATABASE_URL)
        yield conn
    except Exception as e:
        print(f"DB Connection failed: {e}")
        raise
    finally:
        if conn:
            await conn.close()