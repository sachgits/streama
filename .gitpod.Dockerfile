FROM ubuntu:latest

ENV OPENJDK8_VERSION 8
ENV GRADLE_VERSION 3.0

RUN     cd /opt && \
        apt-get -y install openjdk8=${OPENJDK8_VERSION} curl bash libstdc++ && \
        curl -jkSL -o gradle.zip https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && unzip gradle.zip -d /opt && rm gradle.zip && \
        ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle &&\
        rm /var/cache/apk/*

ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV PATH ${PATH}:/opt/gradle/bin
