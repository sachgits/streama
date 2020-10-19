FROM ubuntu:latest

# Define working directory.
RUN mkdir -p /workspace
WORKDIR /workspace

# Define volume: your local app code directory can be mounted here
# Mount with: -v /your/local/directory:/data/app
VOLUME ["/workspace"]
# Allow the host to use gradle cache, otherwise gradle will always download plugins & artifacts on every build
VOLUME ["/root/.gradle/caches/"]

# Install Java and curl (Open JDK)
RUN \
    apt-get update && \
    apt-get -y install unzip openjdk-8-jdk && \
    apt-get -y install curl

# Download and install Gradle
RUN \
    cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-3.0-bin.zip -o gradle-3.0-bin.zip && \
    unzip gradle-3.0-bin.zip && \
    rm gradle-3.0-bin.zip

# Export some environment variables
ENV GRADLE_HOME=/usr/local/gradle-3.0
ENV PATH=$PATH:$GRADLE_HOME/bin JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
