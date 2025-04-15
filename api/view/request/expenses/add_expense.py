from pydantic import Field, BaseModel

class AddExpenseRequest(BaseModel):
    amount: float = Field(
        ...,
        gte=0,
        title='Expense Amount',
        description='The amount spent. Must be greater than 0.'
    )
    category: int = Field(
        ...,
        title='Category ID',
        description='Numeric ID representing the expense category.'
    )