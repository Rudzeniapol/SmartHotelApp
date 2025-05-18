from typing import Annotated

from fastapi import Depends, FastAPI, HTTPException, status, Header
from jwt import ExpiredSignatureError, InvalidTokenError

from app.auth.service import decode_access_token
from app.repository.queries import get_user_by_phone
from app.auth.schemas import UserSchema


async def get_current_user(token: Annotated[str, Header()]) -> UserSchema:
    try:
        payload = decode_access_token(token)
        phone = payload.get("sub")
        if phone is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")

        user = await get_user_by_phone(phone)
        if user is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="User not found")

        return UserSchema(**user)

    except ExpiredSignatureError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token expired")
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")