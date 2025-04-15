from .base_model import BaseModel
from sqlalchemy import BigInteger, String, NUMERIC
from sqlalchemy.orm import Mapped, mapped_column

class UserModel(BaseModel):
    __tablename__='USER'

    _id:Mapped[int]=mapped_column('_id', BigInteger, primary_key=True, autoincrement=True)
    full_name: Mapped[str] = mapped_column(String(50), nullable=False)
    email: Mapped[str] = mapped_column(String(255), nullable=False, unique=True)
    password: Mapped[str] = mapped_column(String(64), nullable=False)
    salt: Mapped[str] = mapped_column(String(128), nullable=False)
    budget: Mapped[float] = mapped_column(NUMERIC(precision=20, scale=2), nullable=True, default=0)