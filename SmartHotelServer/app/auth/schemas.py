from typing import Annotated
from enum import Enum

from pydantic import BaseModel, Field


class UserRole(str, Enum):
    guest = 'guest'
    admin = 'admin'


class UserLoginFormSchema(BaseModel):
    phone: Annotated[str, Field()]
    password: Annotated[str, Field(min_length=8)]


class UserRegistrationFormSchema(UserLoginFormSchema):
    name: Annotated[str, Field()]


class UserSchema(BaseModel):
    user_id: Annotated[int, Field(ge=0)]
    phone: Annotated[str, Field()]
    role: Annotated[UserRole, Field()]
    name: Annotated[str, Field()]
    room_id: Annotated[int | None, Field()]
    hashed_pswd: Annotated[str, Field(exclude=True)]


class LoginInfoSchema(BaseModel):
    token: Annotated[str, Field()]
    name: Annotated[str, Field()]


class TokenSchema(BaseModel):
    access_token: str
    ble_token: str
    token_type: str