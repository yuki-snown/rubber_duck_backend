# Rubber Debugger (backend)

## 環境開発

### 現状のファイル構成の場合はsh server.shのみで立ち上がる

### 1.以下のグーグルスプレッドシートからcsvファイルをエクスポートする

#### https://docs.google.com/spreadsheets/d/1k5-1gZGVhEzTIJ8hbnyg43jOzIWi8KPyOveJiUB_WME/edit#gid=0 

### 2.エクスポートしたファイルの名前を duck.csv に変更し，df/seeds 以下に配置する

### 3.fast.Dockerfileもしくはlight.Dockerfileの名前をDockerfileに変更

### 4.その後，$sh server.shでコンテナを立ち上げる

<br><br>

## --- interface定義 ---

### - method: GET  URL: /health

### ヘルスチェック用のAPIです

## response
{"msg":"OK"}


### - method: GET  URL: /word

```
* params

    text: string

```

### 検索成功の場合 status: 200, 失敗の場合 status:500 を返す．
### また，検索件数が0件の場合は status: 200 で {"msg":"すいません．分かりません"} というレスポンスを返す

## example

http://localhost/word?text=js%E3%81%8C%E9%9B%A3%E3%81%97%E3%81%84

## response
{"msg":"それが難しいのはどうしてだと思いますか?"}