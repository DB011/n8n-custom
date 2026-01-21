FROM docker.n8n.io/n8nio/n8n:latest

USER root

# 1. Install Chromium using 'apt-get' (Debian) instead of 'apk'
# We also include fonts so the browser can render text correctly
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    && rm -rf /var/lib/apt/lists/*

# 2. Tell Puppeteer to use the Chromium we just installed
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 3. Install the missing plugin
WORKDIR /home/node/.n8n/nodes
RUN npm install puppeteer-extra-plugin-user-preferences

USER node
