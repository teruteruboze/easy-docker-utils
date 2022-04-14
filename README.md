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

#### USE CASE3: 他人のイメージを使いまわして自分のコンテナを立ち上げたい場合
`bash create-baseimage.sh`は実行済みであると仮定
* 今のスクリプトは、イメージに自分のユーザーを割り当てている
* したがって、他人が作ったイメージを使いまわして自分のコンテナを作る場合は、ユーザーの切り替えが必要
* そうしなければ、ファイル操作が`permission denied`となる
* Dockerは、ファイルの差分だけを保存してディスク容量を節約するので、ユーザーごとにイメージから作り直して、この作業はやらないという手もある
1. `conf.txt`で`USER_SWITH=1`とする
2. `bash create-container.sh`を再実行するだけ
※ ターミナルの表示が若干おかしくなるので、もう少し他のやり方がないか調査中

## 注意事項
* マウントするディレクトリが無指定の場合は、現在のディレクトリ（=**bashを実行したディレクトリ**)がマウントされます（スクリプトがあるディレクトリではないので注意してください）
* ベースイメージによっては、使い物にならないことがあります

## ブランチと作成されるコンテナの環境
* teruteruboze/lab-pytorch => Pytorch+CUDA10.2を使ったコンテナを立ち上げる場合のサンプルスクリプト

## TODO
* attachなどのコマンドも、スクリプトで実行できるようにアップデートする予定
* イメージにユーザーアカウントを紐付けているが、これをコンテナ立ち上げ時に紐付けできないか

## チートシート: Dockerの使い方

### コンテナからログアウトする(detach)
* ctrl+p のあと ctrl+q を押す
* この場合、バックグラウンドでコンテナが動作するため`docker ps`でコンテナ名が表示される

### detachのあと、再度コンテナにログインする(attach)
* 以下のコマンドを実行
```
docker attach taro_pytorch_classification-container
```
### コンテナを停止する(stop)
* コンテナ内でexitを入力し、Enterを押す
* もしくは、detach後に以下のコマンドを実行
```
docker stop taro_pytorch_classification-container
```

### stopのあと、再度コンテナを起動してログインする
* 以下のコマンドを実行
* stopすると`docker ps`ではコンテナ情報が表示されないため、どうしても確認したい場合は、`docker ps -a`とする
```
docker start taro_pytorch_classification-container
docker attach taro_pytorch_classification-container
```

### コンテナの削除（共有マシン＆しばらく使わない場合は、削除するのがマナー）
* 以下のコマンドを実行（コンテナIDは、`docker container ls -a`から確認可能）
```
docker rm コンテナID
```

### イメージの削除
* 以下のコマンドを実行（イメージIDは、`docker image ls`から確認可能）
```
docker rmi イメージID
```
