from .base_model import BaseModel
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy import BigInteger, String, Boolean

class CategoriesModel(BaseModel):
    __tablename__='CATEGORIES'

    _id:Mapped[int]=mapped_column('_id', BigInteger, primary_key=True, autoincrement=True)
    name:Mapped[str]=mapped_column('name', String(30), nullable=False)
    stored_icon_path:Mapped[str]=mapped_column('stored_icon_path', String(100), nullable=False)
    is_good:Mapped[bool]=mapped_column('is_good', Boolean, nullable=False, default=False)