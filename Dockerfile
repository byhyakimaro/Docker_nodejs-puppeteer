# ------------------------------------
# Pterodactyl Core Dockerfile
# KnowNetoworks Nodejs with puppeteer
# ------------------------------------

FROM        node:20-buster-slim

LABEL       author="Hyakimaro" maintainer="knownetworks@protonmail.com"

RUN         apt update \
            && apt -y install wget gnupg procps libxss1 ffmpeg iproute2 git sqlite3 python3 ca-certificates tzdata dnsutils build-essential \
            && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
            && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
            && apt update \
            && apt install -y google-chrome-stable \
            && rm -rf /var/lib/apt/lists/* \
            && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
            && chmod +x /usr/sbin/wait-for-it.sh \
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
