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
    python3.8-dev \
    python3-pip \
    gfortran \ 
    libopenblas-dev \
    liblapack-dev \
    libhdf5-dev \
    autoconf \
    libtool \
    pkg-config \
    python-opengl \
    python-pil \
    python-pyrex \
    idle-python2.7 \
    libgle3 \
    libssl-dev \
    libfreetype6-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
RUN pip install --upgrade pip
COPY ./requirements.txt /requirements.txt
RUN pip install --upgrade pip
RUN pip install Cython
RUN pip install --upgrade Cython
RUN pip install notebook
RUN pip install jupyter
RUN pip install pyzmq --upgrade
RUN pip install ipykernel --upgrade
RUN pip install traitlets --upgrade
RUN pip install -r /requirements.txt

ARG UID
RUN useradd docker -l -u ${UID} -s /bin/bash -m
USER docker

ENV PATH=$PATH:/home/docker/.local/bin