FROM ubuntu:latest


# Allow the host to use gradle cache, otherwise gradle will always download plugins & artifacts on every build
VOLUME ["/root/.gradle/caches/"]

# Allow the host to use grails cache, otherwise grails will always download plugins & artifacts on every build
VOLUME ["/workspace/streama/.m2/repository"]


# Install Java and curl wget (Open JDK)
RUN \
    apt-get update && \
    apt-get -y install unzip openjdk-8-jdk && \
    apt-get -y install curl wget unzip

# Download and install Gradle
RUN \
    cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-3.0-bin.zip -o gradle-3.0-bin.zip && \
    unzip gradle-3.0-bin.zip && \
    rm gradle-3.0-bin.zip


# Set customizable env vars defaults.
ENV GRAILS_VERSION 3.2.6
ENV GRAILS_DEPENDENCY_CACHE_DIR /workspace/streama/.m2/repository


# Install Grails
WORKDIR /usr/lib/jvm
RUN wget https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
 unzip grails-$GRAILS_VERSION.zip && \
 rm -rf grails-$GRAILS_VERSION.zip && \
 ln -s grails-$GRAILS_VERSION grails

# Setup Grails path.
ENV GRAILS_HOME /usr/lib/jvm/grails
ENV PATH $GRAILS_HOME/bin:$PATH


# Export some environment variables
ENV GRADLE_HOME=/usr/local/gradle-3.0
ENV PATH=$PATH:$GRADLE_HOME/bin JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Define working directory.
RUN mkdir -p /workspace/streama
WORKDIR /workspace/streama

# Define volume: your local app code directory can be mounted here
# Mount with: -v /your/local/directory:/data/app
VOLUME ["/workspace/streama"]
