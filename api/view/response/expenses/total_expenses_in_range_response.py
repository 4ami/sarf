from ..base_response import BaseResponse
from .total_expenses import TotalExpenses
from pydantic import Field
from typing import Optional

class TotalExpensesInRangeResponse(BaseResponse):
    expenses:Optional[list[TotalExpenses]]=Field(
        default=None,
        title='Total Expenses'
    )