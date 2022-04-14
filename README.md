# easy-docker-utils
DockerのImageからcontainer立ち上げコマンドが覚えられない人向けのお役立ちツールです。</br>
書き換えて使う場合は、Forkかブランチを切ることをおすすめします。
```
git checkout -b hogehoge
# git push -u origin HEAD # リモートにブランチを登録しないならやらなくて良い
```

## 使い方
### 基本的な使い方
1. conf.txt に必要事項を入力（以下は例）
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

2. requirements.txt にpipで入れたいフレームワーク名を記載（基本的にバージョンも指定するのがセオリーです）
3. 必要であれば、Dockerfile を改修（例えば、pythonを入れるなど）
4. このリポジトリのディレクトリで、以下のコマンドを実行
```
bash create-baseimage.sh
```
一時的にカスタムのイメージを作ります</br>
5. このリポジトリのディレクトリで、以下のコマンドを実行
```
bash create-container.sh
```
カスタムで一時的に作ったイメージからコンテナを作るコマンドです</br>
6. Docker内でマウントしたディレクトリにアクセスするには、下記のコマンドを実行する
```
cd /work
```

#### USE CASE1: マウントするディレクトリだけを変えて別のコンテナを立ち上げる場合
`bash create-baseimage.sh`は実行済みであると仮定
1. `conf.txt`の`WORK_DIR=""`を書き換え
2. `bash create-container.sh`を再実行するだけ

#### USE CASE2: 転送するポートだけを変えて別のコンテナを立ち上げる場合
`bash create-baseimage.sh`は実行済みであると仮定
1. `conf.txt`の`PORT=""`を書き換え
2. `bash create-container.sh`を再実行するだけ

## コンテナの終了方法と立ち上げ
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

## 注意事項
* マウントするディレクトリが無指定の場合は、現在のディレクトリ（=**bashを実行したディレクトリ**)がマウントされます（スクリプトがあるディレクトリではないので注意してください）
* ベースイメージによっては、使い物にならないことがあります

## ブランチと作成されるコンテナの環境
* teruteruboze/lab-pytorch => Pytorch+CUDA10.2を使ったコンテナを立ち上げる場合のサンプルスクリプト

## TODO
* attachなどのコマンドも、スクリプトで実行できるようにアップデートする予定
