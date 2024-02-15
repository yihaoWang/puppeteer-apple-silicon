# Build stage
FROM node:16-bullseye-slim AS builder
WORKDIR /app

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV DEBIAN_FRONTEND=noninteractive

# Install node libraries
COPY package.json ./
RUN npm install

# Run server
FROM node:16-bullseye-slim
WORKDIR /app

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV CHROME_PATH=/usr/bin/chromium
ENV DEBIAN_FRONTEND=noninteractive

# Get needed libraries for puppeteer
RUN apt-get update --fix-missing -y && \
    apt-get install -y --no-install-recommends \
    gnupg libgconf-2-4 libxss1 libxtst6 build-essential chromium chromium-sandbox \
    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

# COPY files
COPY --from=builder /app /app
COPY ./code /app/code