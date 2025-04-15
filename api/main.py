from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from middelware import ServerErrorHandlerMiddleWare, TokenGaurdMiddleware

app:FastAPI=FastAPI(
    title='Sarf API'
)

app.add_middleware(
    CORSMiddleware, 
    allow_origins=['*'], 
    allow_methods=['POST','GET','PUT','DELETE'], 
    allow_headers=["*"],
    allow_credentials=True
)

from routes import auth, expenses, user, category
from conf import PROTECTED_ENDPOINTS

app.add_middleware(ServerErrorHandlerMiddleWare)
app.add_middleware(TokenGaurdMiddleware, protected=PROTECTED_ENDPOINTS)

app.include_router(auth)
app.include_router(expenses)
app.include_router(user)
app.include_router(category)