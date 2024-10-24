FROM debian:bullseye-slim AS builder

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
        acme \
        build-essential \
        ca-certificates \
        default-jre \
        git \
        parallel \
        python3 \
        rsync \
        sudo \
        unzip \
        xxd \
    && ln -s /usr/bin/acme /usr/local/bin/acme \
    && echo "#!/bin/sh" > /usr/local/bin/osascript \
    && echo "echo NOP osascript" >> /usr/local/bin/osascript \
    && chmod +x /usr/local/bin/osascript

ADD https://api.bitbucket.org/2.0/repositories/magli143/exomizer/commits/master exomizer-version.json

RUN git clone -b master https://bitbucket.org/magli143/exomizer.git \
    && cd exomizer/src \
    && make \
    && cp exomizer /usr/bin \
    && rm -rf /exomizer

ADD https://api.github.com/repos/mach-kernel/cadius/git/refs/heads/master cadius-version.json

RUN git clone -b master https://github.com/mach-kernel/cadius.git \
    && cd cadius \
    && make \
    && cp bin/release/cadius /usr/bin \
    && rm -rf /cadius

ARG BEFORE_CMD=echo NOP
ARG BRANCH=main
ARG IMAGE
ARG REPOSITORY
ARG TARGET

ADD https://api.github.com/repos/a2-4am/${REPOSITORY}/git/refs/heads/${BRANCH} ${REPOSITORY}-version.json

RUN ${BEFORE_CMD} \
    && git clone -b ${BRANCH} https://github.com/a2-4am/${REPOSITORY}.git \
    && cd ${REPOSITORY} \
    && chmod 755 bin/* || : \
    && make ${TARGET} \
    && cp "/${REPOSITORY}/build/${IMAGE}" "/tmp/${IMAGE}" \
    && rm -rf ${REPOSITORY}

FROM scratch

ARG IMAGE
ARG REPOSITORY

COPY --from=builder "/tmp/${IMAGE}" /