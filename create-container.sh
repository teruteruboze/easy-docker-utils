#!/bin/bash
BASE_IMAGE_NAME="" # ベースとなるIMAGEの名前
BASE_IMAGE_TAG="" # ベースとなるIMAGEのタグ
BUILD_IMAGE_NAME="" # ビルドされるIMAGEの名前（ユニークなものをつける）
CONTAINER_NAME=""
WORK_DIR="" # マウントしたいディレクトリの絶対パス（なにも入力しない場合、今いるディレクトリをマウントします）
USE_GPU=1 # GPUありなら1、そうでなければ0
PORT="" # ポートを使うならポート番号（使わないなら空欄）
BACKGROUND=0 # バックグラウンド実行なら1、そうでなければ0

# =================================================
if test "$WORK_DIR" = "" ; then
  WORK_DIR=`pwd`
fi
if test $USE_GPU -eq 1 ; then
  USE_GPU="--gpus all"
else
  USE_GPU=""
fi
if test "$PORT" != "" ; then
  PORT="-p "$PORT":8888"
fi
if test $BACKGROUND -eq 1 ; then
  BACKGROUND="-d"
else
  BACKGROUND=""
fi
# =================================================
docker build -t "$BUILD_IMAGE_NAME" -f Dockerfile --build-arg IMAGE="$BASE_IMAGE_NAME" TAG="$BASE_IMAGE_TAG" UID=`id -u` .
# =================================================
CREATE_CONTAINER_COMMAND="docker run "$BACKGROUND" -it "$USE_GPU" "$PORT" -v "$WORK_DIR":/work --name "$CONTAINER_NAME" "$BUILD_IMAGE_NAME""
$CREATE_CONTAINER_COMMAND