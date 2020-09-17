FROM ubuntu:18.04

ENV USER dotfiles

RUN apt-get update -y \
 && apt-get install -y \
    curl \
    sudo \
 && useradd -m -s /bin/bash ${USER} \
 && gpasswd -a ${USER} sudo \
 && echo "${USER}:masaki" | chpasswd
USER ${USER}
WORKDIR /home/dotfiles