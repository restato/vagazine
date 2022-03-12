from fastapi import APIRouter
from fastapi_redis_cache import cache
from util import misc, scrap

router_items = APIRouter(prefix='/items', tags=['items'])

@router_items.get('/', summary='List of Items', description='return all items')
@cache(expire=60)
def get_items():
    items = misc.read_yaml('data/for-baby-food.yaml')
    for idx, item in enumerate(items):
        data = {}
        data = scrap.do(item['url'])
        item.update(data)
        item['title'] = item["title"]
        item['id'] = idx
    return items
