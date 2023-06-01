FROM ubuntu:latest

ENV USER dotfiles

RUN apt-get update -y \
 && apt-get install -y \
    sudo \
 && useradd -m -s /bin/bash ${USER} \
 && gpasswd -a ${USER} sudo \
 && echo "${USER}:dotfiles" | chpasswd
USER ${USER}
WORKDIR /home/dotfiles
