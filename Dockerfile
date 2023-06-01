FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

# Install System dependencies
RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install \
        software-properties-common \
        curl \
        unzip \
        bash \
        python3-pip \
        python3.10-venv \     
        git \
        jq \
        zsh

ENV NODE_VERSION=14.18.2
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN npm i duckdb-async

# Install the dependencies file to the working directory
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

ENV PYTHONPATH "${PYTHONPATH}:/sport_odds/lab/src/src"

## Setup lab tree

# WORKDIR /lab

# COPY lab .
