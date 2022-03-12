import os
import logging
from typing import Optional
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI, Request, Response
from fastapi_redis_cache import FastApiRedisCache, cache
from sqlalchemy.orm import Session
from config import cfg

from util import scrap
from util import misc
from models import Item
from routers import item

logger = logging.getLogger(__name__)
app = FastAPI(title='vagazine')
app.include_router(item.router_items)

origins = [
    '*'
    # "http://localhost",
    # "http://localhost:8000",
    # "http://localhost:3000",
    # "http://localhost:19006",
    # "http://localhost:19000",
    # "http://localhost:65340",
    # "https://vagazine.netlify.app/"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/ping")
async def ping():
    return 'pong'

@app.on_event('startup')
async def startup():
    if cfg.redis_url:
        redis_cache = FastApiRedisCache()
        redis_cache.init(
            host_url=os.environ.get("REDIS_URL", cfg.redis_url),
            prefix="myapi-cache",
            response_header="X-MyAPI-Cache",
            ignore_arg_types=[Request, Response, Session]
        )
    # Connect to database
    # await db.connect()

@app.on_event('shutdown')
async def shutdown():
    pass
    # await db.disconnect()
