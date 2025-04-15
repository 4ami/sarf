from .base_response import BaseResponse
from pydantic import Field
class ServerErrorResponse(BaseResponse):
    code:int=Field(500)
    message:str=Field('Server-side Error')