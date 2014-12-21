# Base image
FROM ubuntu:14.04

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y software-properties-common
RUN sudo apt-add-repository -y ppa:webupd8team/java && apt-get -y update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true \
	| debconf-set-selections && \
	echo debconf shared/accepted-oracle-license-v1-1 seen true \
	| debconf-set-selections  && \
	apt-get -y install oracle-java7-installer
RUN apt-get install -y wget unzip

# Which version of the server should be downloaded
ENV srv_v 1_1_2
ENV srv_url_base http://www.creeperrepo.net/FTB2/modpacks
ENV srv_url $srv_url_base%5EMagic_World_2%5E$srv_v%5EMagicWorld2Server.zip

# Create data folder and download server
RUN mkdir /server
WORKDIR /server
RUN wget -A.zip "$srv_url" -O magic_world_2.zip
RUN unzip magic_world_2.zip
RUN rm magic_world_2.zip *.bat *.sh

# Mark data folder as volume
VOLUME /data
# Change execution environment to /data
WORKDIR /data

# Expose standard server port
EXPOSE 25565

# How much memory should the server use
ENV srv_mem 768M

# Start the server with previously set memory limit
ENTRYPOINT /data/./entrypoint.sh
