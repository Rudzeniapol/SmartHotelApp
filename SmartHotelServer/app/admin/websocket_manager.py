from typing import Dict, List, DefaultDict
from collections import defaultdict
from fastapi import WebSocket
import json
import asyncio
import random
from datetime import datetime


class ConnectionManager:
    def __init__(self):
        self.active_connections: DefaultDict[str, List[WebSocket]] = defaultdict(list)

    async def connect(self, websocket: WebSocket, room_identifier: str):
        await websocket.accept()
        self.active_connections[room_identifier].append(websocket)
        print(f"Client connected to room {room_identifier}. Total clients for room: {len(self.active_connections[room_identifier])}")

    def disconnect(self, websocket: WebSocket, room_identifier: str):
        if websocket in self.active_connections[room_identifier]:
            self.active_connections[room_identifier].remove(websocket)
            if not self.active_connections[room_identifier]:
                del self.active_connections[room_identifier]

    async def send_personal_message(self, message: str, websocket: WebSocket):
        try:
            await websocket.send_text(message)
        except Exception as e:
            print(f"Error sending personal message: {e}")

    async def broadcast_to_room(self, room_identifier: str, message: dict):
        message_str = json.dumps(message)
        connections_in_room = list(self.active_connections.get(room_identifier, []))
        for connection in connections_in_room:
            try:
                await connection.send_text(message_str)
            except Exception as e:
                self.disconnect(connection, room_identifier)


manager = ConnectionManager()


async def emulate_room_data_sender():
    """
    Эмулирует отправку данных (например, температуры) в комнаты каждые N секунд.
    """
    print("DEBUG: emulate_room_data_sender started.")
    while True:
        print("DEBUG: Top of while True loop.")  # <--- Добавьте это
        await asyncio.sleep(5)
        print("DEBUG: After asyncio.sleep(5).")  # <--- Добавьте это
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