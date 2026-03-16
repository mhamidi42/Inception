#!/bin/bash
set -e

# Dossier où seront placés les certificats
SSL_PATH="/etc/nginx/ssl"

# Si les certificats n'existent pas déjà, on les crée
if [ ! -f "$SSL_PATH/nginx.crt" ] || [ ! -f "$SSL_PATH/nginx.key" ]; then
  echo "🔐 Generation d'un certificat SSL auto-signe..."

  if [ -z "$DOMAIN_NAME" ]; then
    echo "Error: DOMAIN_NAME variable is not set."
    exit 1
  fi
  
  openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout "$SSL_PATH/nginx.key" \
    -out "$SSL_PATH/nginx.crt" \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=Inception/CN=${DOMAIN_NAME}"
  echo "✅ SSL certificate generated!"
fi
