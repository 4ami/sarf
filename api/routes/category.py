from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse
from sqlalchemy.ext.asyncio import AsyncSession

category:APIRouter=APIRouter(
    prefix='/category',
    tags=['Category']
)

from conf import GET_ENGINE
from controller import CategoryController


from view import CategoriesResponse, BaseResponse

@category.get(
    path='/all',
    response_model=CategoriesResponse,
    status_code=200
)
async def all(
    session:AsyncSession|None=Depends(GET_ENGINE)
)->BaseResponse:
    res:CategoriesResponse= await CategoryController.all(session=session)
    return JSONResponse(
        status_code=res.code,
        content=res.model_dump(exclude_none=True)
    )