FROM docker.io/n8nio/n8n:latest-debian

USER root

# --- ARCHIVE FIX START ---
# Fixes "404 Not Found" by pointing to the Debian Archive for the old Buster OS
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until
# --- ARCHIVE FIX END ---

# Now install Chromium
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    && rm -rf /var/lib/apt/lists/*

# Configure Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Install the plugin
WORKDIR /home/node/.n8n/nodes
RUN npm install puppeteer-extra-plugin-user-preferences

USER node
