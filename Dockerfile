# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.17

RUN \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    openssh \
    rsnapshot \
    rsync \
    python3 \
    py3-pip \
    python3-dev \
    gnupg \
    git \
    curl \
    nano \
    pigz \
    tar \
    zstd && \
  echo "**** install PIP3 packages ****" && \
  pip3 install -U --no-cache-dir \
    pip \
    wheel && \
  pip install --no-cache-dir --ignore-installed \
    awscli \
    awsebcli \
    s3cmd && \
  echo "**** cleanup ****" && \
  rm -rf \
      /root/.cache \
      /tmp/*

# copy local files
COPY root/ /

# ports and volumes
VOLUME /config
