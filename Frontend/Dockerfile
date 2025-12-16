# Build Stage
FROM node:18-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# No execution stage - artifacts are in /app/dist
# To use: docker build -t frontend-build .
# To extract: docker create --name temp frontend-build && docker cp temp:/app/dist ./dist && docker rm temp