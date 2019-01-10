# escape=\
ARG BASE_IMAGE=ubuntu:16.04

FROM ${BASE_IMAGE}

COPY . /scilla

WORKDIR /scilla

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:tah83/secp256k1 -y \
    && apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    m4 \
    ocaml \
    opam \
    pkg-config \
    zlib1g-dev \
    libgmp-dev \
    libffi-dev \
    libssl-dev \
    libsecp256k1-dev \
    libboost-system-dev \
    && rm -rf /var/lib/apt/lists/*

# ARG OPENSSL_INSTALL_DIR=/opt/openssl
# ENV CPLUS_INCLUDE_PATH=${OPENSSL_INSTALL_DIR}/include
# ENV LIBRARY_PATH=${OPENSSL_INSTALL_DIR}/lib
# ENV LD_LIBRARY_PATH=${OPENSSL_INSTALL_DIR}/lib

# RUN cd ${HOME} \
#     && curl -LO https://github.com/openssl/openssl/archive/OpenSSL_1_1_1a.tar.gz \
#     && tar zxvf OpenSSL_1_1_1a.tar.gz && cd openssl-OpenSSL_1_1_1a \
#     && ./config --prefix=${OPENSSL_INSTALL_DIR} --openssldir=${OPENSSL_INSTALL_DIR} \
#     && make -j$(nproc) && make install && cd ${HOME} \
#     && rm -rf OpenSSL_1_1_1a.tar.gz openssl-OpenSSL_1_1_1a

RUN cd /scilla && make opamdep \
    && echo '. ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true ' >> ~/.bashrc \
    && eval `opam config env` && \
    make
