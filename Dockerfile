FROM barichello/godot-ci:4.6.2

USER root

RUN apt-get update && apt-get install -y \
    fontconfig \
    openjdk-17-jdk-headless \
    wget \
    unzip \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Download export templates
RUN wget -O /tmp/templates.tpz https://github.com/godotengine/godot/releases/download/4.6.2-stable/Godot_v4.6.2-stable_export_templates.tpz && \
    mkdir -p /root/.local/share/godot/export_templates/4.6.2.stable && \
    cd /root/.local/share/godot/export_templates/4.6.2.stable && \
    unzip -o /tmp/templates.tpz && \
    rm /tmp/templates.tpz

# Copy templates to the expected user directory (GitHub runner's home)
RUN mkdir -p /github/home/.local/share/godot/export_templates/4.6.2.stable && \
    cp -r /root/.local/share/godot/export_templates/4.6.2.stable/* /github/home/.local/share/godot/export_templates/4.6.2.stable/

WORKDIR /github/workspace

CMD ["godot", "--version"]
