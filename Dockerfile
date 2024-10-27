ARG ALPINE_VERSION=3.20.3

FROM alpine:${ALPINE_VERSION} AS builder

RUN apk add --update-cache \
        bash \
        build-base \
        findutils \
        gcc \
        ca-certificates \
        openjdk17-jre-headless \
        git \
        parallel \
        python3 \
        rsync \
        sudo \
        unzip \
        xxd \
    && rm -rf /var/cache/apk/* \
    && echo "#!/bin/sh" > /usr/local/bin/osascript \
    && echo "echo NOP osascript" >> /usr/local/bin/osascript \
    && chmod +x /usr/local/bin/osascript

RUN git clone -b main https://github.com/visrealm/acme.git \
    && cd acme/src \
    && make install \
    && rm -rf /acme

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

FROM alpine:${ALPINE_VERSION}

ARG IMAGE
ENV IMAGE_FILE=${IMAGE}
ENV MOUNT_POINT=/mnt/output

RUN mkdir -p ${MOUNT_POINT} 

COPY --from=builder "/tmp/${IMAGE}" /

CMD ["sh", "-c", "mkdir -p ${MOUNT_POINT}/build && cp -f \"/${IMAGE_FILE}\" ${MOUNT_POINT}/build/ && echo \"${IMAGE_FILE} copied.\"" ]
