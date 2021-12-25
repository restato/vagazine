from typing import Optional

from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from util import scrap

app = FastAPI()
origins = [
    "http://localhost.tiangolo.com",
    "https://localhost.tiangolo.com",
    "http://localhost",
    "http://localhost:8000",
    "http://localhost:19006",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Item(BaseModel):
    name: str
    price: float
    is_offer: Optional[bool] = None

@app.get("/")
def read_root():
    urls = ['https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=5585680852&itemId=119183238&vendorItemId=324094168',
            'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=59780&itemId=557613526&vendorItemId=4464944239',
            'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=18188945&itemId=73212309&vendorItemId=3119796648',
            'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=18188945&itemId=73212309&vendorItemId=3119796648']
    results = []
    for idx, url in enumerate(urls):
        result = scrap.coupang(url)
        result['id'] = idx
        result['url'] = url
        results.append(result)
    return  results

@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}

@app.put("/itmes/{item_id}")
def update_item(item_id: int, item: Item):
    return {"item_name": item.name, "item_id": item_id}