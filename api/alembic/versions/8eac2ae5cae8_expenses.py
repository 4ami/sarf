"""expenses

Revision ID: 8eac2ae5cae8
Revises: 23ab5046866c
Create Date: 2025-04-13 14:42:26.008034

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '8eac2ae5cae8'
down_revision: Union[str, None] = '23ab5046866c'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'USER_EXPENSES',
        sa.Column(name='_id', type_=sa.BigInteger, primary_key=True, autoincrement=True),
        sa.Column(name='user', type_=sa.BigInteger, nullable=False),
        sa.Column(name='expense', type_=sa.NUMERIC(precision=20, scale=2), nullable=False),
        sa.Column(name='category', type_=sa.BigInteger, nullable=True),
        sa.Column(name='date', type_=sa.DATE, nullable=False, server_default=sa.text('CURRENT_DATE'))
    )

    op.create_foreign_key(
        constraint_name=None,
        source_table='USER_EXPENSES',
        local_cols=['user'],
        referent_table='USER',
        remote_cols=['_id'],
        ondelete='CASCADE',
        onupdate='CASCADE'
    )
    op.create_foreign_key(
        constraint_name=None,
        source_table='USER_EXPENSES',
        local_cols=['category'],
        referent_table='CATEGORIES',
        remote_cols=['_id'],
        ondelete='SET NULL',
        onupdate='CASCADE'
    )


def downgrade() -> None:
   op.drop_table('USER_EXPENSES')
