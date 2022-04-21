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
    libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
RUN pip install --upgrade pip
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh

ARG UID
RUN useradd docker -l -u ${UID} -s /bin/bash -m
USER docker

ENV PATH=$PATH:/home/docker/.local/bin