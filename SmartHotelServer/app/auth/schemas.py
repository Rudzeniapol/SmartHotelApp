from typing import Annotated

from pydantic import BaseModel, Field


class UserLoginFormSchema(BaseModel):
    number: Annotated[str, Field()]
    password: Annotated[str, Field(min_length=8)]


class TokenSchema(BaseModel):
    access_token: str
    ble_token: str
    token_type: str