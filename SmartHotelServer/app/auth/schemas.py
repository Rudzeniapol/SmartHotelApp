from typing import Annotated

from pydantic import BaseModel, Field


class UserLoginFormSchema(BaseModel):
    phone: Annotated[str, Field()]
    password: Annotated[str, Field(min_length=8)]


class UserRegistrationFormSchema(UserLoginFormSchema):
    name: Annotated[str, Field()]


"""
{
  "token": "jwt_token_здесь",
  "userName": "имя_пользователя",
  "user": {
    "id": "id_пользователя",
    "phone": "номер_телефона",
    "fullName": "полное_имя",
    "role": "роль_пользователя"
  }
}
"""

class LoginInfoSchema(BaseModel):
    token: Annotated[str, Field()]
    name: Annotated[str, Field()]


class TokenSchema(BaseModel):
    access_token: str
    ble_token: str
    token_type: str