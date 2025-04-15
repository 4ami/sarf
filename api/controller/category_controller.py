from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.engine import Result
from model import CategoriesModel

from sqlalchemy.future import select

from view import ServerErrorResponse, CategoriesResponse, BaseResponse, Category


class CategoryController:
    @staticmethod
    async def all(
        session:AsyncSession|None
    )->BaseResponse:
        try:
            if not session: raise Exception()

            stmt=select(CategoriesModel)
            res:Result=await session.execute(stmt)

            categories:list[Category] = [
                Category(
                    id=i._id, 
                    name=i.name, 
                    stored_icon_path=i.stored_icon_path, 
                    is_good=i.is_good
                ) 
                for i in res.scalars()
            ]
            


            if not categories: return CategoriesResponse(
                code=404,
                message='No categories available'
            )

            return CategoriesResponse(
                code=200,
                categories=categories
            )
        except Exception as e:
            print(e)
            return ServerErrorResponse()