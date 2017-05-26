#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget subversion python2.7 libgdiplus && \
  rm -rf /var/lib/apt/lists/*

# Add Mendix build files
ADD build-mda /root/build-mda
RUN chmod +x /root/build-mda
RUN git clone -b master https://github.com/WebFlight/cf-mendix-buildpack.git /root/cf-mendix-buildpack


# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Set build and output directory
VOLUME /tmp
VOLUME /releases

# Define default command.
CMD ["./build-mda"]
