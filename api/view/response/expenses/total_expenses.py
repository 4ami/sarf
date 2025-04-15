from pydantic import BaseModel

class TotalExpenses(BaseModel):
    category:int
    total:float