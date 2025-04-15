"""user_migration

Revision ID: ba2b287eda67
Revises: 
Create Date: 2025-04-13 12:01:52.204408

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'ba2b287eda67'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'USER',
        sa.Column(name='_id', type_=sa.BigInteger, primary_key=True, autoincrement=True),
        sa.Column(name='full_name', type_=sa.String(50), nullable=False),
        sa.Column(name='email', type_=sa.String(255), nullable=False, unique=True),
        sa.Column(name='password', type_=sa.String(64), nullable=False),
        sa.Column(name='salt', type_=sa.String(128), nullable=False),
        sa.Column(name='budget', type_=sa.NUMERIC(precision=20, scale=2), nullable=True, default=0)
    )


def downgrade() -> None:
    op.drop_table('USER')
