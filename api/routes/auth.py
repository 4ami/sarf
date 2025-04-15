from fastapi import APIRouter, Depends
from conf import GET_ENGINE

from sqlalchemy.ext.asyncio import AsyncSession

from controller import UserController

from fastapi.responses import JSONResponse

auth:APIRouter = APIRouter(
    prefix='/auth',
    tags=['AUTH']
)

from view import BaseResponse, RegisterRequest, RegisterResponse, REGISTER_RESPONSES
@auth.post(
    path='/register',
    response_model=RegisterResponse,
    status_code=201,
    responses=REGISTER_RESPONSES
)

async def register(
    req:RegisterRequest,
    session:AsyncSession|None=Depends(GET_ENGINE)
)->BaseResponse:
    res:BaseResponse = await UserController.register(user=req, session=session)
    
    return JSONResponse(
        status_code=res.code,
        content= res.model_dump(exclude_none=True)
    )


from view import LoginResponse, LoginRequest, LOGIN_RESPONSES
@auth.post(
    path='/login',
    response_model=LoginResponse,
    status_code=200,
    responses=LOGIN_RESPONSES
)
async def login(
    req:LoginRequest,
    session:AsyncSession|None=Depends(GET_ENGINE)
)-> BaseResponse:
    res:BaseResponse = await UserController.login(credentials=req, session=session)
    return JSONResponse(
        status_code=res.code,
        content= res.model_dump(exclude_none=True)
    )


from view import TokenResponse, TOKEN_RESPONSES
@auth.post(
    path='/token',
    response_model=TokenResponse,
    status_code=200,
    responses=TOKEN_RESPONSES
)
def token(token:str|None = Depends(UserController.authorization_header))->BaseResponse:
    res:BaseResponse = UserController.token(reftoken=token)
    return JSONResponse(
        status_code=res.code,
        content=res.model_dump(exclude_none=True)
    )