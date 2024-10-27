FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
        acme \
        build-essential \
        ca-certificates \
        default-jre-headless \
        git \
        parallel \
        python3 \
        rsync \
        subversion \
        unzip \
        xxd \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/acme /usr/local/bin/acme \
    && echo "#!/bin/sh" > /usr/local/bin/osascript \
    && echo "echo NOP osascript" >> /usr/local/bin/osascript \
    && chmod +x /usr/local/bin/osascript

# RUN svn checkout https://svn.code.sf.net/p/acme-crossass/code-0/trunk acme \  
#     && cd acme/src \
#     && make install \
#     && rm -rf /acme

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

# ADD --chmod=777 https://github.com/mach-kernel/cadius/releases/download/1.4.5/cadius-linux /usr/bin/cadius
