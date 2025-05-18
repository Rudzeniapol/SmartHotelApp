from typing import Annotated

from fastapi import APIRouter, Body, HTTPException, status, WebSocket, WebSocketDisconnect, Depends, Path
from fastapi.responses import JSONResponse

from app.auth.schemas import UserRegistrationFormSchema
from app.auth import service as auth_service
from app.config import SUPERUSER_PASSWORD
from app.auth.schemas import UserSchema
from app.admin.dependencies import get_current_admin
from app.repository import queries
from app.admin.websocket_manager import manager as websocket_manager

admin_router = APIRouter()

@admin_router.get("/")
async def healthcheck():
    return {"status": "ok"}


@admin_router.post("/register")
async def register(user_data: Annotated[UserRegistrationFormSchema, Body()],
                   superuser_password: str):
    if superuser_password != SUPERUSER_PASSWORD:
        return HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Incorrect superuser password")
    if await auth_service.is_user_exist(user_data.phone):
        raise HTTPException(status_code=400, detail="User already exists")
    if await auth_service.register_user(user_data, role='admin'):
        return JSONResponse({'message': 'admin is registered!'}, status.HTTP_201_CREATED)


# for websockets its necessary to provide front-end!
@admin_router.websocket("/ws/room/{room_number}")
async def websocket_room_endpoint(
    websocket: WebSocket,
    room_number: Annotated[str, Path(title="The ID of the room to connect to")]
):
    room = await queries.get_room_by_number(room_number)
    if room is None:
        await websocket.close(code=status.WS_1008_POLICY_VIOLATION)
        print(f"Attempt to connect to non-existent room {room_number}")
        return

    room_id = room["room_id"]

    await websocket_manager.connect(websocket, room_id)
    try:
        await websocket_manager.send_personal_message(f"You are connected to room {room_id}", websocket)

        while True:
            data = await websocket.receive_text()
            print(f"Room {room_id} client sent: {data}")

    except WebSocketDisconnect:
        websocket_manager.disconnect(websocket, room_id)
        print(f"Client disconnected gracefully from room {room_id}")
    except Exception as e:
        print(f"Error in WebSocket for room {room_id}: {e}")
        websocket_manager.disconnect(websocket, room_id)
        try:
            await websocket.close(code=status.WS_1011_INTERNAL_ERROR)
        except RuntimeError:
            pass