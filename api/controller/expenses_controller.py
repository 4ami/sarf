from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.engine import Result
from model import UserExpensesModel

from sqlalchemy.future import select
from sqlalchemy import func
from sqlalchemy.orm import aliased



from view import (
    BaseResponse,
    ServerErrorResponse,
    AddExpenseRequest,
    AddExpenseResponse,
    TotalExpenses,
    TotalExpensesInRangeRequest,
    TotalExpensesInRangeResponse,
)

class UserExpensesController:
    @staticmethod
    async def add(
        data:AddExpenseRequest,
        _id:int,
        session:AsyncSession|None
    )->BaseResponse:
        try:
            if not session: raise Exception('Session is not initialized')
        
            new_expense:UserExpensesModel= UserExpensesModel(
                user=_id,
                expense=data.amount,
                category=data.category
            )

            session.add(new_expense)
            await session.commit()
            await session.refresh(new_expense)
            
            return AddExpenseResponse(code=201, expense_id=new_expense._id)
        except Exception as e:
            print(e)
            return ServerErrorResponse()
    
    @staticmethod
    async def get_range(
        data:TotalExpensesInRangeRequest,
        _id:int,
        session:AsyncSession|None
    )->BaseResponse:
        try:
            if not session: raise Exception('Session is not initialized')

            stmt=select(
                UserExpensesModel.category, func.sum(UserExpensesModel.expense)
            ).where(
                (UserExpensesModel.user == _id) &
                (UserExpensesModel.date >= data.from_date) &
                (UserExpensesModel.date <= data.to_date) 
            ).group_by(UserExpensesModel.category)

            res:Result = await session.execute(stmt)

            expenses:list[TotalExpenses]=[TotalExpenses(category= c, total= t) for c, t in res.all()]

            if not expenses:
                return TotalExpensesInRangeResponse(
                    code=404,
                    message='No expenses in given range'
                )

            return TotalExpensesInRangeResponse(
                code=200,
                expenses=expenses
            )
        except Exception as e:
            print(e)
            return ServerErrorResponse()