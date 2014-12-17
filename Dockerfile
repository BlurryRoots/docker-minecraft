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
	apt-get -y install oracle-java8-installer
RUN apt-get install -y wget

# Which version of the server should be downloaded
ENV srv_v 1.8.1
ENV srv_url_base https://s3.amazonaws.com/Minecraft.Download/versions
ENV srv_url $srv_url_base/$srv_v/minecraft_server.$srv_v.jar

# How much memory should the server use
ENV srv_mem 768M

# Create data folder and download server
RUN mkdir /server
RUN wget -A.jar "$srv_url" -O /server/minecraft_server.jar
# Mark data folder as volume
VOLUME /data

# Expose standard server port
EXPOSE 25565

WORKDIR /data
# Start the server with previously set memory limit
ENTRYPOINT /data/./entrypoint.sh
