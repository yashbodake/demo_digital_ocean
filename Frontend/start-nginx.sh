#!/bin/sh

echo "Starting NGINX setup..."
echo "Current PORT value: $PORT"

# Default to port 80 if PORT is not set
if [ -z "$PORT" ]; then
    echo "PORT not set, defaulting to 80"
    export PORT=80
fi

# Check if BACKEND_URL is set
if [ -z "$BACKEND_URL" ]; then
    echo "CRITICAL ERROR: BACKEND_URL environment variable is not set!"
    echo "Please set BACKEND_URL in your Digital Ocean App Platform settings."
    echo "Example: https://your-backend-app.ondigitalocean.app"
    # Fallback to prevent immediate crash loop for easier debugging, but warn heavily
    echo "WARNING: Setting BACKEND_URL to 'http://backend-not-configured' to allow NGINX startup."
    export BACKEND_URL="http://backend-not-configured"
fi

# Substitute $PORT and $BACKEND_URL in the configuration
echo "Substituting PORT ($PORT) and BACKEND_URL ($BACKEND_URL) in nginx.conf..."
envsubst '$PORT $BACKEND_URL' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start Nginx
echo "Starting nginx..."
exec nginx -g 'daemon off;'
