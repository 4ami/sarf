from pydantic import Field, BaseModel

class SetBudgetRequest(BaseModel):
    budget:float=Field(
        ...,
        title='User Budget'
    )