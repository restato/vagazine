
### Getting Started

```
https://dongsan.club
```

```sh
uvicorn main:app --reload --host 0.0.0.0
# uvicorn src.main:app --reload # 프로젝트가 src/main.py 라면
```

### Heroku에 배포하기

* 프로젝트 ROOT에 Procfile, requirements.txt, runtime.txt 파일이 존재해야 한다.
* 단, 외국에 호스트가 있어 만약 국내 서비스 조회를 통한 (=스크랩)을 한다면 동작하지 않는다. 

```sh
$ brew tap heroku/brew && brew install herokuit add .
$ git commit -am "make it better"
$ git push heroku master
# heroku create # 사이트에서 만들면 할필요 없음
$ git init
$ heroku git:remote -a vagazine # origin, heroku
$ heroku logs --tail # 로그 확인
```

# COUPANG

* 리워드
  * https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=5585680852&itemId=119183238&vendorItemId=3240941688
  * https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=59780&itemId=557613526&vendorItemId=4464944239
  * https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=18188945&itemId=73212309&vendorItemId=3119796648
  * https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=18188945&itemId=73212309&vendorItemId=3119796648
* 리워드 없음
  * https://link.coupang.com/re/NONPROFITSDP?lptag=CFM60714948&pageKey=18188945&itemId=73212309&vendorItemId=3119796648
