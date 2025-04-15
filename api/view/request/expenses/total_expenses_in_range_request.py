from pydantic import Field, BaseModel
from datetime import date

class TotalExpensesInRangeRequest(BaseModel):
    from_date:date=Field(
        ...,
        title='Starting Date',
        description='Format: YYYY-MM-DD'
    )
    to_date:date=Field(
        ...,
        title='Starting Date',
        description='Format: YYYY-MM-DD'
    )