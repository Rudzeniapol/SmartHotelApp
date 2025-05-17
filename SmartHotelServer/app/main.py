from contextlib import asynccontextmanager

from fastapi import FastAPI

from app.auth.routes import auth_router
from app.repository.init_db import create_tables
from app.hotel.routes import hotel_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    await create_tables()
    yield

app = FastAPI(lifespan=lifespan)

app.include_router(auth_router, prefix="/auth", tags=["auth"])
app.include_router(hotel_router, prefix="/hotel", tags=["hotel"])

@app.get("/")
async def root():
    return {"healthcheck": "ok"}
