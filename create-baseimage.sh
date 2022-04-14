#!/bin/bash
source ./conf.txt
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
CREATE_CONTAINER_COMMAND="docker run "$BACKGROUND" -it "$USE_GPU" "$PORT" -v "$WORK_DIR":/work --name "$CONTAINER_NAME" "$BUILD_IMAGE_NAME""
$CREATE_CONTAINER_COMMAND