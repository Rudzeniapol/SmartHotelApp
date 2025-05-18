from typing import Dict, List, DefaultDict
from collections import defaultdict
from fastapi import WebSocket
import json
import asyncio

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