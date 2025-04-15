from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse
from sqlalchemy.ext.asyncio import AsyncSession

user:APIRouter=APIRouter(
    prefix='/user',
    tags=['User']
)

from conf import GET_ENGINE
from middelware import decode
from controller import UserController

from view import BaseResponse, UpdateBudgetResponse, SetBudgetRequest

@user.put(
    path='/budget',
    response_model=UpdateBudgetResponse,
    status_code=200
)
async def set_budget(
    req:SetBudgetRequest,
    user_id:int=Depends(decode),
    session:AsyncSession|None=Depends(GET_ENGINE)
)->BaseResponse:
    res:UpdateBudgetResponse=await UserController.set_budget(
        data=req, _id=user_id, session=session
    )
    return JSONResponse(
        status_code=res.code,
        content=res.model_dump(exclude_none=True)
    )