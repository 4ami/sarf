from ..base_response import BaseResponse
from pydantic import Field
from typing import Optional

class RegisterResponse(BaseResponse):
    token:Optional[str]=Field(
        default=None,
        title='Jwt Token'
    )
    ref_token:Optional[str]=Field(
        default=None,
        title='Jwt Referesh Token'
    )

from ..server_error_response import ServerErrorResponse
REGISTER_RESPONSES:dict={
    400:{
        'model':RegisterResponse,
        'content':{
            'application/json':{
                'example': RegisterResponse(code=400, message='Account is already registered').model_dump()
            }
        }
    },
    500:{
        'model':ServerErrorResponse,
        'content':{
            'application/json':{
                'example':ServerErrorResponse().model_dump()
            }
        }
    }
}