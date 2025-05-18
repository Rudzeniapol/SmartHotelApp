from fastapi import APIRouter


admin_router = APIRouter()


@admin_router.get("/")
async def healthcheck():
    return {"status": "ok"}