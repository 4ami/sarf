from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from conf import GET_ENGINE
from middelware import decode

from fastapi.responses import JSONResponse

from controller import UserExpensesController

expenses:APIRouter = APIRouter(
    prefix='/expenses',
    tags=['Expenses']
)

from view import AddExpenseRequest, AddExpenseResponse, BaseResponse, ADD_EXPENSE_RESPONSES


@expenses.post(
    path='/add',
    response_model= AddExpenseResponse,
    status_code=201,
    responses=ADD_EXPENSE_RESPONSES
)
async def add(
    req: AddExpenseRequest,
    user_id:int=Depends(decode),
    session: AsyncSession|None=Depends(GET_ENGINE)
)-> BaseResponse:
    res:BaseResponse = await UserExpensesController.add(data=req, _id=user_id, session=session)
    return JSONResponse(
        status_code=res.code,
        content=res.model_dump(exclude_none=True)
    )

from view import TotalExpensesInRangeRequest, TotalExpensesInRangeResponse
@expenses.post(
    path='/range',
    response_model=TotalExpensesInRangeResponse,
    status_code=200
)
async def get_range(
    req:TotalExpensesInRangeRequest,
    user_id:int=Depends(decode),
    session: AsyncSession|None=Depends(GET_ENGINE)
)-> BaseResponse:
    res:TotalExpensesInRangeResponse = await UserExpensesController.get_range(
        data=req, _id=user_id, session=session
    )
    return JSONResponse(
        status_code=res.code,
        content=res.model_dump(exclude_none=True)
    )