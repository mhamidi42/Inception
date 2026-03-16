# Utiliser Debian comme base (autorisée par le sujet)
FROM debian:bookworm

# Mettre à jour et installer les paquets nécessaires
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    mariadb-client \
    curl \
    wget \
    tar \
    unzip \
    less \
    vim \
    gnupg2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Créer un dossier pour WordPress
RUN mkdir -p /var/www/html /run/php

# Télécharger et extraire WordPress
RUN curl -o /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf /tmp/latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/latest.tar.gz

# Copier la configuration PHP-FPM personnalisée
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Copier le script d’installation WordPress
COPY tools/wp-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-setup.sh

# Exposer le port utilisé par php-fpm
EXPOSE 9000

# Lancer php-fpm via le script d’installation
ENTRYPOINT ["/usr/local/bin/wp-setup.sh"]
