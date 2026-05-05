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

# Download and extract templates, then move them up one level
RUN wget -O /tmp/templates.tpz https://github.com/godotengine/godot/releases/download/4.6.2-stable/Godot_v4.6.2-stable_export_templates.tpz && \
    mkdir -p /github/home/.local/share/godot/export_templates/4.6.2.stable && \
    cd /github/home/.local/share/godot/export_templates/4.6.2.stable && \
    unzip -o /tmp/templates.tpz && \
    mv templates/* . && \
    rmdir templates && \
    rm /tmp/templates.tpz

WORKDIR /github/workspace

CMD ["godot", "--version"]
