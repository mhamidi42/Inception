#!/bin/bash
set -e

MYSQL_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/php

# Attendre que la base MariaDB soit prête
echo "⏳ Waiting for MariaDB to be ready..."
until mariadb -h mariadb -P ${SQL_PORT} -u${SQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1;" > /dev/null 2>&1; do
  sleep 3
done
echo "✅ MariaDB is ready!"

# Configurer WordPress si ce n'est pas déjà fait
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "🛠️ Setting up WordPress..."

  # Télécharger WP-CLI (outil officiel)
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp

  cd /var/www/html

  # Créer le fichier de configuration wp-config.php
  wp config create \
    --dbname=${SQL_DATABASE} \
    --dbuser=${SQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=mariadb:${SQL_PORT} \
    --allow-root

  # Installer WordPress
  wp core install \
    --url=${WP_URL} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

  # Créer un utilisateur standard
  wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --allow-root
fi

# Donner les bons droits
chown -R www-data:www-data /var/www/html

# Lancer php-fpm (PID 1)
exec /usr/sbin/php-fpm8.2 -F
