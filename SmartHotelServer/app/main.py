from contextlib import asynccontextmanager
import asyncio

from fastapi import FastAPI

from app.auth.routes import auth_router
from app.repository.init_db import create_tables
from app.hotel.routes import hotel_router
from app.admin.routes import admin_router
from app.admin.websocket_manager import emulate_room_data_sender


@asynccontextmanager
async def lifespan(app: FastAPI):
    await create_tables()
    print("Starting up... Starting data emulator task.")
    # emulator_task = asyncio.create_task(emulate_room_data_sender())
    yield
    # print("Shutting down... Cancelling data emulator task.")
    # emulator_task.cancel()
    # try:
    #     await emulator_task
    # except asyncio.CancelledError:
    #     print("Data emulator task cancelled.")

app = FastAPI(lifespan=lifespan)

app.include_router(auth_router, prefix="/auth", tags=["auth"])
app.include_router(hotel_router, prefix="/hotel", tags=["hotel"])
app.include_router(admin_router, prefix="/admin", tags=["admin"])

@app.get("/")
async def root():
    return {"healthcheck": "ok"}
