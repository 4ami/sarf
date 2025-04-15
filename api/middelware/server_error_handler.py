from starlette.middleware.base import BaseHTTPMiddleware
from view import ServerErrorResponse
from fastapi.responses import JSONResponse
import logging
import traceback

logger=logging.getLogger('uvicorn.error')

class ServerErrorHandlerMiddleWare(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        try:
            return await call_next(request)
        except Exception as e:
            logger.error(f"Unhandled error: {str(e)}")
            return JSONResponse(
                status_code=ServerErrorResponse().code,
                content=ServerErrorResponse().model_dump(exclude_none=True)
            )