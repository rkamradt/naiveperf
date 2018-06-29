# Gatling is a highly capable load testing tool.
#
# Documentation: https://gatling.io/docs/2.3/
# Cheat sheet: http://gatling.io/#/cheat-sheet/2.3

FROM openjdk:8-jdk-alpine

MAINTAINER Randal Kamradt <randykamradt@gmail.com>

# working directory for gatling
WORKDIR /opt

# gating version
ENV GATLING_VERSION 2.3.1

# create directory for gatling install
RUN mkdir -p gatling

# install gatling
RUN apk add --update wget bash && \
  mkdir -p /tmp/downloads && \
  wget -q -O /tmp/downloads/gatling-$GATLING_VERSION.zip \
  https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip && \
  mkdir -p /tmp/archive && cd /tmp/archive && \
  unzip /tmp/downloads/gatling-$GATLING_VERSION.zip && \
  mv /tmp/archive/gatling-charts-highcharts-bundle-$GATLING_VERSION/* /opt/gatling/ && \
  rm -rf /tmp/* && \
  rm -rf /opt/gatling/user-files

# copy simulation and configuration
COPY . gatling

# change context to gatling directory
WORKDIR  /opt/gatling

# set environment variables
ENV PATH /opt/gatling/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV GATLING_HOME /opt/gatling

ENTRYPOINT ["gatling.sh"]
