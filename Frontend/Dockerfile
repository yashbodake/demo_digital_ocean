# Use official Node runtime as parent image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Vue.js app for production
RUN npm run build

# Use nginx to serve the built app
FROM nginx:alpine

# Copy the built Vue.js app to nginx's html directory
COPY --from=0 /app/dist /usr/share/nginx/html

# Copy custom nginx configuration as a template
COPY nginx.conf /etc/nginx/nginx.conf.template

EXPOSE 80

# Substitute $PORT in the configuration and start nginx
CMD ["/bin/sh", "-c", "envsubst '$PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]