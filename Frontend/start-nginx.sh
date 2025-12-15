#!/bin/sh

echo "Starting NGINX setup..."
echo "Current PORT value: $PORT"

# Default to port 80 if PORT is not set
if [ -z "$PORT" ]; then
    echo "PORT not set, defaulting to 80"
    export PORT=80
fi

# Substitute $PORT in the configuration
echo "Substituting PORT in nginx.conf..."
envsubst '$PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start Nginx
echo "Starting nginx..."
exec nginx -g 'daemon off;'
