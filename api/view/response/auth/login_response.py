from ..base_response import BaseResponse
from pydantic import Field
from typing import Optional

class LoginResponse(BaseResponse):
    token:Optional[str]=Field(
        default=None,
        title='Jwt Token'
    )
    ref_token:Optional[str]=Field(
        default=None,
        title='Jwt Referesh Token'
    )

from ..server_error_response import ServerErrorResponse
LOGIN_RESPONSES:dict={
    404:{
        'model':LoginResponse,
        'content':{
            'application/json':{
                'example': LoginResponse(code=404, message='Invalid Email/Password').model_dump()
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