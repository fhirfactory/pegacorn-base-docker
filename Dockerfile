FROM alpine:3.12

# Update the operating system
#RUN apk update && \
#    apk upgrade --no-cache

# START equivalent of https://github.com/jboss-dockerfiles/base/blob/master/Dockerfile

# Create a group and user and disable user login
RUN addgroup -g 1000 -S jboss && adduser -u 1000 -S jboss -G jboss -D -s /sbin/nologin jboss && \
    mkdir -p /opt/jboss && \
    chmod 755 /opt/jboss

# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss

# Switch to jboss user
#USER jboss

# END equivalent of https://github.com/jboss-dockerfiles/base/blob/master/Dockerfile

# START equivalent of https://github.com/jboss-dockerfiles/base-jdk/blob/jdk11/Dockerfile

# User root to install Java software
USER root

# Set JAVA home path
ENV JAVA_HOME /usr/lib/jvm/default-jvm

# Install Java 11 [Proxy prevents this operation]
RUN apk add --no-cache openjdk11

# Has to be set explictly to find binaries 
ENV PATH=$PATH:${JAVA_HOME}/bin

# Add bash [Proxy prevents this operation]
RUN apk add --no-cache bash

# Switch to jboss user
USER jboss
ENV USER=jboss HOME=/opt/jboss

# END equivalent of https://github.com/jboss-dockerfiles/base-jdk/blob/jdk11/Dockerfile

