from .base_model import BaseModel
from sqlalchemy import BigInteger, DATE, NUMERIC, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column
from datetime import datetime

from sqlalchemy import text

class UserExpensesModel(BaseModel):
    __tablename__='USER_EXPENSES'

    _id:Mapped[int]=mapped_column('_id', BigInteger, primary_key=True, autoincrement=True)
    user:Mapped[int]=mapped_column('user', BigInteger, ForeignKey('USER._id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False)
    expense:Mapped[float]=mapped_column('expense', NUMERIC(precision=20, scale=2), nullable=False)
    category:Mapped[int]=mapped_column('category', BigInteger, ForeignKey('CATEGORIES._id', ondelete='SET NULL', onupdate='CASCADE'), nullable=True)
    date:Mapped[datetime]=mapped_column('date', DATE, nullable=False, server_default=text('CURRENT_DATE'))