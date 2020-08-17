FROM ubuntu:latest

RUN apt-get update &&  apt install sudo -y
RUN sudo apt-get update && sudo apt install gnupg software-properties-common -y
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
RUN sudo add-apt-repository 'deb [arch=amd64] https://onepassword.s3.amazonaws.com/linux/debian edge main'

COPY . .

RUN ./update.sh
