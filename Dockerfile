FROM barichello/godot-ci:4.6.2

USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
    fontconfig \
    openjdk-17-jdk-headless \
    wget \
    unzip \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Download and install Godot export templates
RUN mkdir -p /root/.local/share/godot/export_templates/4.6.2.stable && \
    wget -O /tmp/templates.tpz https://github.com/godotengine/godot/releases/download/4.6.2-stable/Godot_v4.6.2-stable_export_templates.tpz && \
    cd /root/.local/share/godot/export_templates/4.6.2.stable && \
    unzip -o /tmp/templates.tpz

# Set working directory
WORKDIR /github/workspace

CMD ["godot", "--version"]
