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
            'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=18188945&itemId=73212309&vendorItemId=3119796648',
            'https://search.shopping.naver.com/catalog/28679532555?cat_id=50000216&frm=NVSCPRO&query=%EB%8F%84%EB%A7%88&NaPm=ct%3Dkxlt4ank%7Cci%3D96314611bb7b8ae588392184bb7127e14d5c811f%7Ctr%3Dsls%7Csn%3D95694%7Chk%3Dc018cd0acf8165ba5025281620fc9f3bfe178307',
            'https://search.shopping.naver.com/catalog/22766289732?cat_id=50000216&frm=NVSCPRO&query=%EB%8F%84%EB%A7%88&NaPm=ct%3Dkxlhzpcw%7Cci%3D582e1a74c939ca66a4c834f93da443380d27eb19%7Ctr%3Dsls%7Csn%3D95694%7Chk%3D0ef0a2f686bd4f745dac9cf8a3896e6eae550a46'
            ]
    results = []
    for idx, url in enumerate(urls):
        if 'coupang' in url:
            result = scrap.coupang(url)
        elif 'catalog' in url:
            result = scrap.naver_catalog(url)
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