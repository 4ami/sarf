from ..base_response import BaseResponse
from pydantic import Field
from typing import Optional


class TokenResponse(BaseResponse):
    token:Optional[str]=Field(
        default=None,
        title='Token'
    )


from ..server_error_response import ServerErrorResponse
TOKEN_RESPONSES:dict= {
    401:{
        'model':TokenResponse,
        'content':{
            'application/json':{
                'example': TokenResponse(code=401, message= 'Missing Authorization').model_dump()
            }
        }
    },
    403:{
        'model':TokenResponse,
        'content':{
            'application/json':{
                'example': TokenResponse(code=403, message= 'Not Authorized').model_dump()
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