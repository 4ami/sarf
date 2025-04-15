from ..base_response import BaseResponse
from ..server_error_response import ServerErrorResponse
from pydantic import Field
from typing import Optional

class AddExpenseResponse(BaseResponse):
    expense_id: Optional[int] = Field(
        default=None,
        title='Expense ID',
        description='Unique identifier for the newly created expense.'
    )

ADD_EXPENSE_RESPONSES: dict = {
    201: {
        'model': AddExpenseResponse,
        'content': {
            'application/json': {
                'example': AddExpenseResponse(
                    code=201,
                    message='Expense created successfully',
                    expense_id=23456222
                ).model_dump()
            }
        }
    },
    400: {
        'model': BaseResponse,
        'content': {
            'application/json': {
                'example': BaseResponse(
                    code=400,
                    message='Invalid request body or missing required fields'
                ).model_dump()
            }
        }
    },
    500: {
        'model': ServerErrorResponse,
        'content': {
            'application/json': {
                'example': ServerErrorResponse().model_dump()
            }
        }
    }
}