# 1. Use the official n8n image as the base
FROM docker.n8n.io/n8nio/n8n:latest

# 2. Switch to root user to install packages
USER root

# 3. Install Chromium (The browser) and fonts
# This is crucial for Alpine Linux (which n8n uses)
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# 4. Set Environment Variables for Puppeteer
# This tells the node where to find the browser we just installed
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# 5. Install the missing plugin
# We switch to the nodes directory and force install the missing dependency
WORKDIR /home/node/.n8n/nodes
RUN npm install puppeteer-extra-plugin-user-preferences

# 6. Switch back to the standard user for security
USER node
