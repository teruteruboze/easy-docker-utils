ARG IMAGE
ARG TAG
FROM ${IMAGE}:${TAG}

ENV TZ=Asia/Tokyo \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    make \
    wget \
    curl \
    bzip2 \
    sudo \
    build-essential \
    git \
    vim \
    emacs \
    python3.8 \
    python3-pip \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
RUN pip install --upgrade pip
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ARG UID
RUN useradd docker -l -u ${UID} -s /bin/bash -m
USER docker

ENV PATH=$PATH:/home/docker/.local/bin