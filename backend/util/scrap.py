import requests
from bs4 import BeautifulSoup
import urllib.request


def coupang(url):
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
    response = requests.get(url, headers=headers)
    response.raise_for_status()

    soup = BeautifulSoup(response.content, 'html.parser')
    # image_url
    image_url = f'http:{soup.find("img", class_="prod-image__detail").get("src")}'
    # title
    title = soup.find("h2", class_="prod-buy-header__title").text
    # price
    price = soup.find("div", class_="prod-origin-price").find("span", class_="origin-price").text
    return {'imageUrl': image_url,
            'title': title,
            'price': price}

def naver_catalog(url):
    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    soup = BeautifulSoup(response.content, 'html.parser')
    # image_url
    image_url = soup.find("div", class_="image_thumb__20xyr").find("img").get('src')
    # price
    price = soup.find("div", class_="lowestPrice_low_price__fByaG").find("em").text + "원"
    # title
    title = soup.find("div", class_="top_summary_title__15yAr").find("h2").text

    return {'imageUrl': image_url,
            'title': title,
            'price': price}


