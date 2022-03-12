import requests
from bs4 import BeautifulSoup
import urllib.request


def do(url):
    print(url)
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    soup = BeautifulSoup(response.content, 'html.parser')
    if soup:
        if 'coupang' in url:
            result = _coupang(soup)
        elif 'catalog' in url:
            result = _naver_catalog(soup)
        elif 'smartstore' in url or 'brand':
            result = _naver_smartstore(soup)
    return result

def _coupang(soup):
    image_url = ''
    title = ''
    price = ''
    # image_url
    image = soup.find("img", class_="prod-image__detail")
    if image:
        image_url = f'http:{image.get("src")}'
    # title
    soup_title = soup.find("h2", class_="prod-buy-header__title")
    if soup_title:
        title = soup_title.text
    # price
    soup_price = soup.find("div", class_="prod-sale-price")
    if soup_price:
        price = soup_price.find("span", class_="total-price").text.strip()
        if price == '원':
            soup_price = soup.find("div", class_="prod-origin-price")
            price = soup_price.find("span", class_="origin-price").text
    print(title)
    return {'imageUrl': image_url,
            'title': title,
            'price': price}

def _naver_smartstore(soup):
    # brand store = smart_store
    # image_url
    image_url = soup.find("div", class_="_23RpOU6xpc").find("img").get("src")
    # price
    price = soup.find_all("span", class_="_1LY7DqCnwR")[1].text + "원"
    # title
    title = soup.find("div", class_="CxNYUPvHfB").find("h3").text
    return {'imageUrl': image_url,
            'title': title,
            'price': price}

def _naver_catalog(soup):
    # image_url
    image_url = ''
    price = ''
    title = ''
    soup_image = soup.find("div", class_="image_thumb__20xyr")
    if soup_image:
        image_url = soup_image.find("img").get('src')
    # price
    soup_price = soup.find("div", class_="lowestPrice_low_price__fByaG")
    if soup_price:
        price = soup_price.find("em").text + "원"
    # title
    soup_title = soup.find("div", class_="top_summary_title__15yAr")
    if soup_title:
        title = soup_title.find("h2").text

    return {'imageUrl': image_url,
            'title': title,
            'price': price}

if __name__ == "__main__":
    urls = [
        # 'https://search.shopping.naver.com/catalog/29755159709?cat_id=50000483',
        'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=6357351226&itemId=13404269680&vendorItemId=80658985348',
        'https://www.coupang.com/vp/products/6155608481?itemId=11913018153&vendorItemId=79185917341&q=%EB%B2%A0%EC%9D%B4%EB%B9%84%EB%AC%B4%EB%B8%8C&itemsCount=36&searchId=82308221227c45c48e2a2194c3e53ab1&rank=1&isAddedCart=',
        'https://www.coupang.com/vp/products/346739853?itemId=1100575955&vendorItemId=78041858811&pickType=COU_PICK&q=%EB%8D%B0%EC%9D%BC%EB%A6%AC%EB%9D%BC%EC%9D%B4%ED%81%AC+%EB%B4%89%EB%B4%89+%EC%8A%A4%ED%8C%8C%EC%B6%9C%EB%9D%BC+%EC%84%B8%ED%8A%B8&itemsCount=12&searchId=5974309051754528ae10ae046a867a69&rank=2&isAddedCart=',
        'https://www.coupang.com/vp/products/1235023229?itemId=2229460557&vendorItemId=78619860336&pickType=COU_PICK&q=%ED%93%A8%EC%96%B4%EC%BD%94%EB%A7%88%EC%B9%98+%EC%9D%B4%EC%9C%A0%EC%8B%9D+%EC%B9%BC&itemsCount=36&searchId=0a44c21a384941e0994b6959e7532775&rank=1&isAddedCart=',
        'https://www.coupang.com/vp/products/19244692?itemId=77278003&vendorItemId=3130288707&q=%EB%B0%94%EC%9D%B4%EC%98%A4%EB%A9%94%EC%9D%B4%EB%93%9C+%EB%8F%84%EB%A7%88&itemsCount=36&searchId=bb8df950dada474988c8708ec395c804&rank=2&isAddedCart=',
        'https://www.coupang.com/vp/products/5613734201?itemId=9078146089&vendorItemId=76364416553&q=%EB%9D%BD%EC%95%A4%EB%9D%BD+%EC%9D%B4%EC%9C%A0%EC%8B%9D%EC%9A%A9%EA%B8%B0&itemsCount=36&searchId=b926e3d0b0c04d5194d055c26f900b0e&rank=3&isAddedCart=',
        'https://www.coupang.com/vp/products/6279106286?itemId=12884143224&vendorItemId=80149338975&q=%EB%9D%BD%EC%95%A4%EB%9D%BD+%EC%9D%B4%EC%9C%A0%EC%8B%9D%EC%9A%A9%EA%B8%B0&itemsCount=36&searchId=b926e3d0b0c04d5194d055c26f900b0e&rank=6&isAddedCart=',
        'https://www.coupang.com/vp/products/1332738368?itemId=2357518481&vendorItemId=70353956305&q=%EB%B8%94%EB%A3%A8%EB%A7%88%EB%A7%88+%EC%9D%B4%EC%9C%A0%EC%8B%9D+%EC%9A%A9%EA%B8%B0&itemsCount=36&searchId=0b0b2d3837a647ddbc048964b08a0910&rank=2&isAddedCart=',
        'https://www.coupang.com/vp/products/218758519?itemId=678183789&vendorItemId=4746212833&q=%EC%8A%A4%ED%91%B8%EB%8B%88+%EC%A4%91%EA%B8%B0%EC%8A%A4%ED%91%BC&itemsCount=30&searchId=c5b60db60b024461a392221498f12b63&rank=1&isAddedCart=',
        'https://www.coupang.com/vp/products/1384900?itemId=5987174&vendorItemId=79059353360&q=%EB%A7%88%EC%BB%A4%EC%8A%A4%EC%95%A4%EB%A7%88%EC%BB%A4%EC%8A%A4+%ED%84%B1%EB%B0%9B%EC%9D%B4&itemsCount=36&searchId=bb539c2fed8f46a0b63d680b1e9a753b&rank=15&isAddedCart=',
        'https://www.coupang.com/vp/products/1734766847?itemId=2953117982&vendorItemId=70941630628&q=%EB%8D%B0%ED%8C%94+%ED%95%B8%EB%93%9C%EB%B8%94%EB%9E%9C%EB%8D%94&itemsCount=36&searchId=3a8c1015d3874ef19c0734b28599906e&rank=1&isAddedCart=',
        'https://www.coupang.com/vp/products/6249582601?itemId=12660144801&vendorItemId=79824044399&pickType=COU_PICK&q=%ED%8D%BC%EA%B8%B0+%EC%9D%B4%EC%9C%A0%EC%8B%9D+%ED%81%90%EB%B8%8C&itemsCount=36&searchId=7f2c93250b71467d88a5dcb2f59fba53&rank=2&isAddedCart=',
        'https://www.coupang.com/vp/products/1816368578?itemId=3091232768&vendorItemId=75845723551&q=%EB%B2%A8%EB%9D%BC%EC%BF%A0%EC%A7%84+%EC%9E%BC%ED%8C%9F&itemsCount=36&searchId=d77fe2b44a3c40b787a7d84e67204356&rank=2&isAddedCart=',
        'https://www.coupang.com/vp/products/6357351226?itemId=13404269680&vendorItemId=80658985348&q=%EC%95%84%EC%9D%B4%EB%B3%B4%EB%A6%AC+%EC%8C%80%EA%B0%80%EB%A3%A8&itemsCount=36&searchId=519d2c95a2e54102b8de399066b38c0e&rank=1&isAddedCart=',
        'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=5585680852&itemId=119183238&vendorItemId=324094168',
        'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=59780&itemId=557613526&vendorItemId=4464944239',
        'https://smartstore.naver.com/namugage/products/2544861183?NaPm=ct%3Dkxluyb74%7Cci%3D0zu0001s7arvBJ6UKfoW%7Ctr%3Dpla%7Chk%3D9dae528a00673d332193125a3213af5ca2afee32',
        'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=18188945&itemId=73212309&vendorItemId=3119796648',
        'https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=18188945&itemId=73212309&vendorItemId=3119796648',
        'https://brand.naver.com/spigen/products/5644374859',
        'https://search.shopping.naver.com/catalog/28679532555?cat_id=50000216&frm=NVSCPRO&query=%EB%8F%84%EB%A7%88&NaPm=ct%3Dkxlt4ank%7Cci%3D96314611bb7b8ae588392184bb7127e14d5c811f%7Ctr%3Dsls%7Csn%3D95694%7Chk%3Dc018cd0acf8165ba5025281620fc9f3bfe178307',
        'https://search.shopping.naver.com/catalog/22766289732?cat_id=50000216&frm=NVSCPRO&query=%EB%8F%84%EB%A7%88&NaPm=ct%3Dkxlhzpcw%7Cci%3D582e1a74c939ca66a4c834f93da443380d27eb19%7Ctr%3Dsls%7Csn%3D95694%7Chk%3D0ef0a2f686bd4f745dac9cf8a3896e6eae550a46'
        'https://search.shopping.naver.com/catalog/29755159709?cat_id=50000483',
        'https://www.coupang.com/vp/products/6155608481?itemId=11913018153&vendorItemId=79185917341&q=%EB%B2%A0%EC%9D%B4%EB%B9%84%EB%AC%B4%EB%B8%8C&itemsCount=36&searchId=82308221227c45c48e2a2194c3e53ab1&rank=1&isAddedCart=',
    ]
    for url in urls:
        do(url)