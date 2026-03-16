# Utiliser Debian (autorisée par le sujet)
FROM debian:bookworm

# Installer NGINX et OpenSSL
RUN apt-get update && apt-get install -y nginx openssl

# Créer le répertoire pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Copier le script de génération des certificats
COPY tools/ssl.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ssl.sh

# Copier la configuration NGINX
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Exposer le port HTTPS uniquement
EXPOSE 443

# Lancer NGINX en avant-plan (PID 1)
CMD ["/bin/bash", "-c", "/usr/local/bin/ssl.sh && nginx -g 'daemon off;'"]
