FROM barichello/godot-ci:4.6.2

# Switch to root to install system packages
USER root

# Install missing dependencies: fontconfig (for Godot fonts) and OpenJDK 17 (for Android export)
RUN apt-get update && apt-get install -y \
    fontconfig \
    openjdk-17-jdk-headless \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Switch back to the 'godot' user (created by the base image)
USER godot

# Set working directory
WORKDIR /github/workspace

# Default command (can be overridden)
CMD ["godot", "--version"]
