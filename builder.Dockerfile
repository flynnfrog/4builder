FROM debian:stable-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
		bash \
        ca-certificates \
        default-jre-headless \
        gcc \
        git \
        libc6-dev \
        make \
        parallel \
        python3 \
        rsync \
        subversion \
        unzip \
        wget \
        xxd \
    && rm -rf /var/lib/apt/lists/* \
    && echo "#!/bin/sh" > /usr/local/bin/osascript \
    && echo "echo NOP osascript" >> /usr/local/bin/osascript \
    && chmod +x /usr/local/bin/osascript

ADD https://svn.code.sf.net/p/acme-crossass/code-0/trunk /var/cache/acme-version.json

RUN svn checkout https://svn.code.sf.net/p/acme-crossass/code-0/trunk acme \
    && rm -rf /root/.subversion \
    && cd acme/src \
    && make install \
    && rm -rf /acme

ADD https://api.bitbucket.org/2.0/repositories/magli143/exomizer/commits/master?limit=1&pagelen=1 /var/cache/exomizer-version.json

RUN git clone -b master https://bitbucket.org/magli143/exomizer.git \
    && cd exomizer/src \
    && make \
    && cp exomizer /usr/bin \
    && rm -rf /exomizer

ADD https://api.github.com/repos/mach-kernel/cadius/git/refs/heads/master /var/cache/cadius-version.json

RUN git clone -b master https://github.com/mach-kernel/cadius.git \
    && cd cadius \
    && echo '#define _XOPEN_SOURCE 700' | cat - Src/Dc_Prodos.c > Src/Dc_Prodos.c.new \ 
    && mv -f Src/Dc_Prodos.c.new Src/Dc_Prodos.c \
    && make \
    && cp bin/release/cadius /usr/bin \
    && rm -rf /cadius

RUN wget -O /tmp/merlin.zip https://brutaldeluxe.fr/products/crossdevtools/merlin/Merlin32_v1.2.zip \
    && unzip -d /tmp /tmp/merlin.zip \
    && chmod 755 /tmp/Merlin32_v1.2_b2/Linux/Merlin32 \
    && cp /tmp/Merlin32_v1.2_b2/Linux/Merlin32 /usr/bin \
    && rm -rf /tmp/Merlin32_v1.2_b2 \
    && rm -rf /tmp.merlin.zip
 
ADD https://api.github.com/repos/einar-saukas/ZX0/git/refs/heads/main /var/cache/zx0-version.json

RUN git clone https://github.com/einar-saukas/ZX0 \
    && cd ZX0/src \
    && make CC=gcc CFLAGS="-O3 -march=x86-64 -mtune=generic -fpack-struct=8 -finline-functions -ffast-math -Wall -x c -s -g0 -fomit-frame-pointer -fstrict-aliasing" \
    && mv ./zx0.exe /usr/bin/zx0 \
    && rm -rf /ZX0
