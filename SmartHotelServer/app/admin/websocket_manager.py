from typing import Dict, List, DefaultDict
from collections import defaultdict
from fastapi import WebSocket
import json
import asyncio
import random
from datetime import datetime


class ConnectionManager:
    def __init__(self):
        self.active_connections: DefaultDict[int, List[WebSocket]] = defaultdict(list)

    async def connect(self, websocket: WebSocket, room_id: int):
        await websocket.accept()
        self.active_connections[room_id].append(websocket)
        print(f"Client connected to room {room_id}. Total clients for room: {len(self.active_connections[room_id])}")

    def disconnect(self, websocket: WebSocket, room_id: int):
        if websocket in self.active_connections[room_id]:
            self.active_connections[room_id].remove(websocket)
            print(f"Client disconnected from room {room_id}. Remaining clients for room: {len(self.active_connections[room_id])}")
            if not self.active_connections[room_id]:
                del self.active_connections[room_id]
                print(f"Room {room_id} has no active connections, removed from manager.")

    async def send_personal_message(self, message: str, websocket: WebSocket):
        await websocket.send_text(message)

    async def broadcast_to_room(self, room_id: int, message: dict):
        message_str = json.dumps(message)
        connections_in_room = list(self.active_connections.get(room_id, []))
        for connection in connections_in_room:
            try:
                await connection.send_text(message_str)
            except Exception as e:
                print(f"Error sending to a websocket in room {room_id}: {e}. Removing.")
                self.disconnect(connection, room_id)


manager = ConnectionManager()


async def emulate_room_data_sender():
    """
    Эмулирует отправку данных (например, температуры) в комнаты каждые N секунд.
    """
    while True:
        await asyncio.sleep(5)
        if not manager.active_connections:
            continue

        print("Emulating data send...")
        active_room_ids = list(manager.active_connections.keys())

        for room_id in active_room_ids:
            if manager.active_connections[room_id]:
                temperature = round(random.uniform(18.0, 25.0), 1)
                humidity = round(random.uniform(30.0, 60.0), 1)
                data_to_send = {
                    "type": "room_update",
                    "room_id": room_id,
                    "timestamp": datetime.utcnow().isoformat() + "Z",
                    "data": {
                        "temperature": temperature,
                        "humidity": humidity,
                    }
                }
                print(f"Broadcasting to room {room_id}: {data_to_send}")
                await manager.broadcast_to_room(room_id, data_to_send)
            else:
                print(f"Room {room_id} found in keys but no connections. This might be a bug or race condition.")