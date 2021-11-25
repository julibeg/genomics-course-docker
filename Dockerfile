FROM ubuntu:20.04

# install packages
RUN apt update
#RUN apt upgrade
RUN apt install -y x11vnc xvfb fluxbox less \
	default-jre xterm sudo wget
RUN	DEBIAN_FRONTEND=noninteractive apt install -y git 
RUN apt clean

# add and configure user
RUN useradd -m user -s /bin/bash
RUN echo "shopt -s autocd" >> /home/user/.bashrc

# copy startup script
COPY startup.sh /
RUN chmod +x startup.sh

# export the port for VNC
EXPOSE 5900

# get script to prepare the course materials and run as user
USER user
WORKDIR /home/user
#ADD https://raw.githubusercontent.com/jodyphelan/genomics_course/master/scripts/setup_machine/for_docker.sh setup.sh
RUN mkdir -p git
COPY genomics_course git/genomics_course 
RUN cp git/genomics_course/scripts/setup_machine/for_docker.sh setup.sh
RUN bash setup.sh 

USER root
ENTRYPOINT ["/startup.sh"]
