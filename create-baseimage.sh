#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ""$SCRIPT_DIR"/conf.txt"
# =================================================
docker build . -t "$BUILD_IMAGE_NAME" -f Dockerfile --build-arg IMAGE="$BASE_IMAGE_NAME" --build-arg TAG="$BASE_IMAGE_TAG" --build-arg UID=`id -u`