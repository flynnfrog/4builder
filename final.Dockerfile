FROM 4builder as builder
LABEL stage=4builder

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
    && rm -rf /${REPOSITORY}

FROM alpine:3.20.3
LABEL stage=4final

ARG IMAGE
ENV IMAGE_FILE=${IMAGE}
ENV MOUNT_POINT=/mnt/output

RUN mkdir -p ${MOUNT_POINT} 

COPY --from=builder "/tmp/${IMAGE}" /

CMD ["sh", "-c", "mkdir -p ${MOUNT_POINT}/build && cp -f \"/${IMAGE_FILE}\" ${MOUNT_POINT}/build/ && echo \"${IMAGE_FILE} copied.\"" ]