#!/bin/bash
EXCUTE_DIR=`pwd`
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ""$SCRIPT_DIR"/conf.txt"
# =================================================
if test "$WORK_DIR" = "" ; then
  WORK_DIR="$EXCUTE_DIR"
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
if test $USER_SWITH -eq 1 ; then
  USER="-u `id -u`:`id -g`"
else
  USER=""
fi
# =================================================
CREATE_CONTAINER_COMMAND="docker run "$USER" "$BACKGROUND" -it "$USE_GPU" "$PORT" -v "$WORK_DIR":/work --name "$CONTAINER_NAME" "$BUILD_IMAGE_NAME""
echo "$CREATE_CONTAINER_COMMAND"
$CREATE_CONTAINER_COMMAND