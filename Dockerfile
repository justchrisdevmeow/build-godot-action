FROM barichello/godot-ci:4.6.2

# Stay as root
USER root

# Install missing dependencies
RUN apt-get update && apt-get install -y \
    fontconfig \
    openjdk-17-jdk-headless \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Set working directory
WORKDIR /github/workspace

# Default command
CMD ["godot", "--version"]
