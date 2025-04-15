from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.engine import Result
from sqlalchemy.future import select
from model import UserModel

from fastapi.requests import Request

from utility import HashHelper, TokenHelper


from view import (
    BaseResponse,
    ServerErrorResponse,
    LoginRequest,
    RegisterRequest,
    LoginResponse,
    RegisterResponse,
    TokenResponse,
    SetBudgetRequest,
    UpdateBudgetResponse
)

class UserController:
    @staticmethod
    async def register(
        user: RegisterRequest,
        session:AsyncSession | None,
    )->BaseResponse:
        try:
            # session is not resolved correctly
            if session is None: raise Exception()

            _select=select(UserModel.email).where(UserModel.email==user.email)
            _select_res:Result= await session.execute(_select)
            _usr:UserModel | None= _select_res.scalar_one_or_none()
            
            # account is already exist
            if _usr: return RegisterResponse(code=400, message='Account is already registered')

            hashed, salt=HashHelper.hash(user.password)
            to_add:UserModel= UserModel(
                full_name=user.full_name,
                email=user.email,
                password=hashed,
                salt=salt
            )

            session.add(to_add)
            await session.commit()
            await session.refresh(to_add)

            _1, _2 = TokenHelper.user_pair_tokens(
                payload={
                    '_id': to_add._id,
                    'email': to_add.email,
                    'full_name': to_add.full_name,
                }
            )
            return RegisterResponse(code=201, token=_1, ref_token=_2)
        except Exception as e:
            print(e)
            return ServerErrorResponse()
         
    @staticmethod
    async def login(
        credentials:LoginRequest,
        session:AsyncSession | None
    )->BaseResponse:
        try:
            # session is not resolved correctly
            if session is None: raise Exception()

            # find user by email
            _select=select(UserModel).where(UserModel.email==credentials.email)
            _res:Result= await session.execute(_select)
            _usr:UserModel = _res.scalar_one_or_none()

            # user is not exist
            if _usr is None: return LoginResponse(code=404, message='Invalid Email/Password')

            # compare credentials
            if not HashHelper.compare(
                hashed=_usr.password,
                salt=_usr.salt,
                password=credentials.password
            ): return LoginResponse(code=404, message='Invalid Email/Password')

            # generate token pairs
            _1, _2 = TokenHelper.user_pair_tokens(
                payload={
                    '_id': _usr._id,
                    'email': _usr.email,
                    'full_name': _usr.full_name,
                }
            )
            return LoginResponse(code=200, token=_1, ref_token=_2)
        except Exception as e:
            print(e)
            return ServerErrorResponse()

    @staticmethod
    def token(reftoken:str)->BaseResponse:
        if not reftoken: return TokenResponse(code=401, message='Missing Authorization')

        token:str|None=TokenHelper.token(refToken=reftoken)

        if not token: return TokenResponse(code=403, message='Not Authorized')

        return TokenResponse(code=200, token=token)
    
    @staticmethod
    async def authorization_header(req:Request)->str|None:
        return req.headers.get('Authorization')
    
    @staticmethod
    async def set_budget(
        data:SetBudgetRequest,
        _id:int,
        session:AsyncSession | None
    )->BaseResponse:
        try:
            if session is None: raise Exception()

            stmt=select(UserModel).where(UserModel._id == _id)
            
            res:Result=await session.execute(stmt)

            user:UserModel = res.scalar_one_or_none()

            if not user:
                return UpdateBudgetResponse(code=404, message='User not found')
            
            user.budget = data.budget

            await session.commit()
            await session.refresh(user)
            return UpdateBudgetResponse(
                code=200,
                message='Budget updated successfully'
            )
        except Exception as e:
            print(e)
            return ServerErrorResponse()

        