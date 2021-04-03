# Rubber Debugger (backend)

## 環境開発

### 現状のファイル構成の場合はsh server.shのみで立ち上がる

### server.shを叩かずにappを立ち上げる場合は以下の手順を踏む
* #### https://docs.google.com/spreadsheets/d/1k5-1gZGVhEzTIJ8hbnyg43jOzIWi8KPyOveJiUB_WME/edit#gid=0 からcsvファイルをエクスポートする
* #### 2.エクスポートしたファイルの名前を duck.csv に変更し，db/seeds 以下に配置する
* #### 3.fast.Dockerfileもしくはlight.Dockerfileの名前をDockerfileに変更
* #### 4.その後，$sh server.shでコンテナを立ち上げる


<br>

## --- interface定義 ---

* ### method: GET  URL: /health
    * ヘルスチェック用のAPIです
    * response: {"msg":"OK"}

* ### method: GET  URL: /
    * elizaの言語用のAPIです
    ```
    　query params

        text: string

    ```
    * example: http://localhost?text=js%E3%81%8C%E9%9B%A3%E3%81%97%E3%81%84

    * response: {"msg":'なんでー？'}