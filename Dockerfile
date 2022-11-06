FROM continuumio/anaconda3

RUN apt-get update -y \
    && apt-get upgrade -y

RUN apt-get update && apt-get install -y apt-utils nodejs npm

ARG DOCKER_UID=1000
ARG DOCKER_USER=docker-user
RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER}

WORKDIR /workspace

USER ${DOCKER_USER}
COPY requirements.txt .

RUN pip install --upgrade pip --user && \
    pip install -r requirements.txt

CMD jupyter-lab --no-browser --port=8888 --ip=0.0.0.0 --allow-root