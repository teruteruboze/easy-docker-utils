ARG IMAGE
ARG TAG
FROM ${IMAGE}:${TAG}

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
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG UID
RUN useradd docker -l -u ${UID} -s /bin/bash -m
USER docker

ENV PATH=$PATH:/home/docker/.local/bin