from pydantic import Field, BaseModel
from typing import Optional

class BaseResponse(BaseModel):
    code:Optional[int]=Field(
        default=None,
        title='Response Code',
        description='Code associated with response describe status of response.'
    )
    message:Optional[str]=Field(
        default=None,
        title='Response Message',
        description='Associated message with response.'
    )