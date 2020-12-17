FROM ghcr.io/linuxserver/baseimage-alpine:3.12

# packages as variables
ARG BUILD_PACKAGES="\
    libffi-dev \
    openssl-dev \
    build-base"

ARG RUNTIME_PACKAGES="\
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
    zstd"
    
ARG PIP3_PACKAGES="\
    awscli \
    awsebcli \
    s3cmd"

RUN \
 if [ -n "${BUILD_PACKAGES}" ]; then \
    echo "**** install build packages ****" && \
    apk add --no-cache \
        --virtual=build-dependencies \
        $BUILD_PACKAGES; \
 fi && \
 if [ -n "${RUNTIME_PACKAGES}" ]; then \
    echo "**** install runtime packages ****" && \
    apk add --no-cache \
        $RUNTIME_PACKAGES; \
 fi && \
 if [ -n "${PIP3_PACKAGES}" ]; then \
    echo "**** install PIP3 packages ****" && \
    pip3 install --upgrade \
        $PIP3_PACKAGES; \
 fi && \
 echo "**** cleanup ****" && \
 if [ -n "${BUILD_PACKAGES}" ]; then \
    apk del --purge \
        build-dependencies; \
 fi && \
 rm -rf \
    /root/.cache \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
VOLUME /config
