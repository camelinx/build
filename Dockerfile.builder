FROM docker.io/debian:stable-slim AS builder-base

LABEL maintainer="Sudarsan Raghavan <camelinx@gmail.com>"
LABEL image-type=builder

ENV container docker

RUN apt-get update -y && \
    apt-get install build-essential -y && \
    apt-get install zlib1g zlib1g-dev -y && \
    apt-get install libpcre3 libpcre3-dev -y && \
    apt-get install curl -y && \
    apt-get install git -y

ENV build_dir /usr/local/nginx
ENV openresty_luajit_ver "2.1-20210510"
ENV luajit_install_dir /usr/local/luajit2.1

RUN mkdir -p ${build_dir}/luajit && mkdir -p ${luajit_install_dir} && \
    cd ${build_dir}/luajit && curl -Ls https://github.com/openresty/luajit2/archive/refs/tags/v${openresty_luajit_ver}.tar.gz -o - | tar zx && cd luajit2-${openresty_luajit_ver} && make PREFIX=${luajit_install_dir} && make install PREFIX=${luajit_install_dir}
     
