#!/bin/sh

# Define certificate paths
CERT_DIR="./nginx/certs"
CERT_KEY="$CERT_DIR/nginx.key"
CERT_CRT="$CERT_DIR/nginx.crt"

# Create cert directory if not exists
mkdir -p $CERT_DIR

# Generate SSL certificates
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $CERT_KEY -out $CERT_CRT -subj "/CN=localhost"

# Start the Node.js application
node index.js
