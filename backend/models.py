from pydantic import BaseModel

class Item(BaseModel):
    title: str
    price: float
    image_url: str
