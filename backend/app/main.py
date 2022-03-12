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
from database import *

logger = logging.getLogger(__name__)
app = FastAPI(title='vagazine')

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
    if conn.is_closed():
        conn.connect()

@app.on_event('shutdown')
async def shutdown():
    if not conn.is_closed():
    conn.close()

@app.get("/items")
@cache(expire=60)
def read_items():
    items = misc.read_yaml('data/for-baby-food.yaml')
    for idx, item in enumerate(items):
        data = {}
        data = scrap.do(item['url'])
        item.update(data)
        item['title'] = item["title"]
        item['id'] = idx
    print('end')
    return items

@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}

@app.put("/itmes/{item_id}")
def update_item(item_id: int, item: Item):
    return {"item_name": item.name, "item_id": item_id}