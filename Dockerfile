FROM docker.io/n8nio/n8n:latest-debian

USER root

# --- 1. ARCHIVE FIX (For Debian Buster EOL) ---
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until

# --- 2. INSTALL CHROMIUM ---
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    && rm -rf /var/lib/apt/lists/*

# --- 3. CONFIGURE PUPPETEER ---
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# --- 4. INSTALL PLUGIN ---
WORKDIR /home/node/.n8n/nodes
RUN npm install puppeteer-extra-plugin-user-preferences

# --- 5. SETUP USER & STARTUP ---
USER node

# CRITICAL FIX: Override the default entrypoint script
# This prevents the "operation not permitted" crash
ENTRYPOINT []
CMD ["n8n"]
