from fastapi.requests import Request
from utility import TokenHelper

async def decode(req:Request) -> int | None:
    token:str=req.headers.get('Authorization').split(' ')[-1]
    decoded, is_valid = TokenHelper.verify(
        token=token
    )
    if not is_valid: return None
    return decoded.get('_id')