"""categories

Revision ID: 23ab5046866c
Revises: ba2b287eda67
Create Date: 2025-04-13 14:35:58.425729

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa

import os
import json
from dotenv import load_dotenv
load_dotenv()


# revision identifiers, used by Alembic.
revision: str = '23ab5046866c'
down_revision: Union[str, None] = 'ba2b287eda67'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    
    op.create_table(
        'CATEGORIES',
        sa.Column(name='_id', type_=sa.BigInteger, primary_key=True, autoincrement=True),
        sa.Column(name='name', type_=sa.String(30), nullable=False),
        sa.Column(name='stored_icon_path', type_=sa.String(100), nullable=False),
        sa.Column(name='is_good', type_=sa.Boolean, nullable=False, default=False)
    )

    cols:list[sa.Column]=[
        sa.Column(name='_id', type_=sa.BigInteger, primary_key=True, autoincrement=True),
        sa.Column(name='name', type_=sa.String(30), nullable=True),
        sa.Column(name='stored_icon_path', type_=sa.String(100), nullable=False),
        sa.Column(name='is_good', type_=sa.Boolean, nullable=False, default=False)
    ]
    
    if os.getenv('ENV')=='DEV':
        with open('alembic/seeds/categories.json', 'r') as seed:
            seeder=json.load(seed)
        categories=sa.Table('CATEGORIES', sa.MetaData(),*cols)
        op.bulk_insert(table=categories, rows=seeder)


def downgrade() -> None:
    op.drop_table('CATEGORIES')
