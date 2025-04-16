from starlette.middleware.base import BaseHTTPMiddleware
from utility import TokenHelper
from fastapi.responses import JSONResponse


class TokenGaurdMiddleware(BaseHTTPMiddleware):
    def __init__(self, app, protected:list[str]=[]):
        super().__init__(app)
        self.protected=protected
    
    async def dispatch(self, request, call_next):
        if request.method == "OPTIONS":
            return await call_next(request)
        
        if not request.url.path in self.protected:
            return await call_next(request)
            
        access_token:str = request.headers.get('Authorization')

        if not access_token:
            return JSONResponse(
                status_code=401,
                content={'code': 401, 'message': 'Missing Access Token'}
            )
        
        if not TokenHelper.verify(token=access_token.split(' ')[-1])[1]:
            return JSONResponse(
                status_code=403,
                content={'code': 403, 'message': 'Not Authorized'}
            )
        
        return await call_next(request)
        


