# easy-docker-utils
DockerのImageからcontainer立ち上げコマンドが覚えられない人向けのお役立ちツールです。</br>

## 使い方
1. create-container.sh に必要事項を入力（以下は例）
```
BASE_IMAGE_NAME="pytorch/pytorch" # ベースとなるIMAGEの名前
BASE_IMAGE_TAG="1.9.0-cuda10.2-cudnn7-runtime" # ベースとなるIMAGEのタグ
BUILD_IMAGE_NAME="taro_pytorch_classification-image" # ビルドされるIMAGEの名前（ユニークなものをつける）
CONTAINER_NAME="taro_pytorch_classification-container"
WORK_DIR="/home/taro/Documents/resarch/image/" # マウントしたいディレクトリの絶対パス（なにも入力しない場合、今いるディレクトリをマウントします）
USE_GPU=1 # GPUありなら1、そうでなければ0
PORT="8888" # ポートを使うならポート番号（使わないなら空欄）
BACKGROUND=0 # バックグラウンド実行なら1、そうでなければ0
```
※上記の部分以外は、書き換えないことを推奨
2. requirements.txt にpipで入れたいフレームワーク名を記載（基本的にバージョンも指定するのがセオリーです）
3. 必要であれば、Dockerfile を改修（例えば、pythonを入れるなど）
4. このリポジトリのディレクトリで、以下のコマンドを実行
```
bash create-container.sh
```
これでコンテナが立ち上がり利用可能となります</br>

* 一度コンテナを抜ける場合は、ctrl+p のあと ctrl+q を押す（もしくはexitと入力しEnterを押す）
* 再度コンテナに入るには、以下のコマンドを実行
```
docker attach taro_pytorch_classification-container
```
* 一度コンテナからexitした場合は、以下のコマンドで再開可能
```
docker start taro_pytorch_classification-container
docker attach taro_pytorch_classification-container
```

* なお、rootでログインしたい場合は、次のコマンドを実行する。
```
docker exec -it -u 0 taro_pytorch_classification-image bin/bash
```
※ -image を指定する点に注意

## TODO
* attachなどのコマンドも、スクリプトで実行できるようにアップデートする予定
