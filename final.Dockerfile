FROM 4builder as builder
LABEL stage=4builder

ARG AFTER_CMD=ZWNobyBOT1A=
ARG BEFORE_CMD=ZWNobyBOT1A=
ARG BRANCH=main
ARG IMAGE
ARG REPOSITORY
ARG TARGET

ADD https://api.github.com/repos/a2-4am/${REPOSITORY}/git/refs/heads/${BRANCH} ${REPOSITORY}-version.json

RUN eval `echo ${BEFORE_CMD} | base64 -d `\
    && git clone --progress --verbose -b ${BRANCH} https://github.com/a2-4am/${REPOSITORY}.git \
    && cd ${REPOSITORY} \
    && eval `echo ${AFTER_CMD} | base64 -d `\
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