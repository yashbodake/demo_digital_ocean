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

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]