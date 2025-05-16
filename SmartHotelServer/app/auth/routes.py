from fastapi import APIRouter


auth_router = APIRouter()


@auth_router.get("/login")
async def login(name: str, phone: str, password: str):
    return {
        "message": f"Login {name} {phone}",
        "password": password,
    }