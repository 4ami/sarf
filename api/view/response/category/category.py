from pydantic import BaseModel

class Category(BaseModel):
    id:int
    name:str
    stored_icon_path:str
    is_good:bool