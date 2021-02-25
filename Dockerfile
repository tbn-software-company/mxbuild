#
# Ubuntu Dockerfile
# Modified to use current cf buildpack by James
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image. Update to latest Ubuntu
FROM ubuntu:18.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget subversion python3 python3-pip libgdiplus openjdk-11-jdk && \
  rm -rf /var/lib/apt/lists/*

# Install .NET dependencies in order to run .exe file
RUN apt-get install gnupg ca-certificates && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get update -y && \
    apt-get install mono-devel -y && \
    rm -rf /var/lib/apt/lists/*

# Add Mendix build files
ADD build-mda /root/build-mda
RUN chmod +x /root/build-mda

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Set build and output directory
VOLUME /tmp
VOLUME /releases

# Define default command.
CMD ["./build-mda"]