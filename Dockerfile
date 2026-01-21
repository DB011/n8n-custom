# 1. Switch to the Debian-based image (Crucial for apt-get)
FROM n8nio/n8n:latest-debian

# 2. Switch to root to install packages
USER root

# 3. Install Chromium and fonts using apt-get
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    && rm -rf /var/lib/apt/lists/*

# 4. Tell Puppeteer to use the Chromium we just installed
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 5. Install the missing plugin
WORKDIR /home/node/.n8n/nodes
RUN npm install puppeteer-extra-plugin-user-preferences

# 6. Switch back to the standard user
USER node
