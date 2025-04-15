from ..base_response import BaseResponse
from pydantic import Field
from typing import Optional
from .category import Category

class CategoriesResponse(BaseResponse):
    categories:Optional[list[Category]]=Field(
        default=None,
        title='Available Categories'
    )