# Frontend

* React Native
### Installation

* download nodejs
  * https://nodejs.org/en/download/
* install expo-cli
  * `$ npm install -g expo-cli`
  * `$ npm install expo-cli` # netlify에서 빌드하기 위해서는 -g 옵션 제거해서 설치 (=package.json에 포함)

### Getting started

```sh
$ npm start # or $ expo srart
# $ expo start --web
# $ expo start --ios
# $ expo start --android
```


## Web

### Build

<!-- 
```sh
$ npm i @expo/webpack-config
```

```js
const createExpoWebpackConfig = require("@expo/webpack-config");
module.exports = function(env, argv) {
    env.mode = "development";
    const config = createExpoWebpackConfig(env, argv);
    return config;
  };
``` -->

```sh
$ expo build:web
$ npx serve web-build # web-build가 build후 output
# expo build:ios
# expo build:android
```



* reference
  * https://docs.expo.dev/distribution/publishing-websites/

### Deploy

```sh
# netlify
npm install netlify-cli -g
netlify deploy

# github pages
# npm i --save-dev gh-pages
# npx gh-pages -d web-build
```

```json
/* package.json */
{
    "scripts": {
        "deploy": "netlify deploy --prod",
        "predeploy": "expo build:web"
    }
}
```

```sh
npm run deploy
```

* reference
  * https://docs.expo.dev/distribution/publishing-websites/#netlify
  * https://docs.expo.dev/distribution/publishing-websites/#github-pages