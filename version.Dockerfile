FROM ubuntu:latest

RUN apt-get update &&  apt install sudo -y
RUN sudo apt-get update && sudo apt install gnupg software-properties-common -y
RUN sudo apt-key --keyring /usr/share/keyrings/1password.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
RUN echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
RUN apt-get update
RUN sudo apt-cache show 1password
