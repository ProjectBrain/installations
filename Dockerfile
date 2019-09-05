FROM python:3.7-alpine

ENV DOCKER_COMPOSE_VERSION 1.24.1

RUN apk add --no-cache make git py-pip \
    && apk add --no-cache --virtual .build-deps \
     python-dev libffi-dev openssl-dev gcc libc-dev \
    && pip install --no-cache-dir docker-compose==${DOCKER_COMPOSE_VERSION} \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

WORKDIR /example

COPY docker-compose.yml .

ENTRYPOINT ["/usr/local/bin/docker-compose", "up", "--remove-orphans"]
