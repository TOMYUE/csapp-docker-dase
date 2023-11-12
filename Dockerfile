# -----------------------------------------------------------------------------------------------------------------
# author: TOMYUE
# date: 2022-11-15
# version: 1.0
# description:
#    This is a Dockerfile for us to make the life in CSAPP a little bit cosier.
#    If you find any errors in this dockerfile, contact me in github: https://github.com/TOMYUE
# -----------------------------------------------------------------------------------------------------------------

FROM ubuntu:22.04

ARG arch_name=amd64
ARG code_server_version=4.18.0
ARG cpptools_version=1.17.5
ARG office_version=3.1.6

RUN cp /etc/apt/sources.list /etc/apt/sources.backup.list

# 如果自己觉得不需要换源的话就把下面这行COPY命令给注释掉，以下命令的使用使得你安装软件包的镜像源来自中科大提供的镜像网站
# 你可以通过查看中科大的镜像网站：https://mirrors.ustc.edu.cn/help/ubuntu.html获取更多信息
# COPY sources.list /etc/apt/sources.list

# 基础开发工具包
RUN apt-get update
RUN apt-get install -y build-essential cmake gdb cgdb python python3 vim emacs locales
RUN apt-get install -y curl wget sudo
RUN useradd -m csapp && \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "csapp ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN locale-gen en_US.UTF-8

ENV LANG=en_US.utf8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# 网络包，aria2是一个轻量级的多协议命令行下载工具，它支持 HTTP、FTP、BitTorrent 等多种协议，可以用来快速、高效地下载文件。
RUN apt-get install -y aria2
# 我们想要下载的code-server版本的原始网站链接为：https://github.com/coder/code-server/releases/download/v4.18.0/code-server_4.18.0_amd64.deb，
# 以下这行命令只是使得命令变得更加通用，可以在code-server更新后下载更新后的版本
RUN aria2c https://github.com/coder/code-server/releases/download/v${code_server_version}/code-server_${code_server_version}_${arch_name}.deb && \
    dpkg -i code-server_${code_server_version}_${arch_name}.deb

RUN apt-get install -y net-tools
RUN usermod -s /bin/bash csapp
RUN chsh -s /bin/bash csapp
ENV SHELL=/bin/bash

# CacheLab
RUN apt-get install -y valgrind

USER csapp

# Office Viewer Extension
RUN mkdir /home/csapp/extensions

# Cpp Extension
# 你可以在这里找到各个发行版本的cpptools: https://github.com/microsoft/vscode-cpptools/releases
ADD cpptools-linux-${cpptools_version}.vsix /home/csapp/extensions
RUN code-server --install-extension /home/csapp/extensions/cpptools-linux-${cpptools_version}.vsix

# C/C++Extension (Belong to MS)
RUN code-server --install-extension ms-vscode.cpptools
# C/C++ IntellisSense
RUN code-server --install-extension ms-vscode.cpptools-extension-pack

# Formatter Extension
RUN code-server --install-extension esbenp.prettier-vscode

# Markdown Extension
RUN code-server --install-extension yzhang.markdown-all-in-one

# Material Theme Extension
RUN code-server --install-extension equinusocio.vsc-material-theme

USER root

# Python3-pip
RUN apt-get update
RUN apt-get install -y python3-dev python3-pip python3-setuptools

RUN chown csapp -R /home/csapp/.local/share/

# RUN cp /etc/apt/sources.list /etc/apt/sources-tencent.list
# RUN mv /etc/apt/sources.backup.list /etc/apt/sources.list
# RUN apt-get update

EXPOSE 8888

ENV PASSWORD=dase

USER csapp

CMD [ "code-server", "--bind-addr", "0.0.0.0:7777", "--auth", "password" ]
