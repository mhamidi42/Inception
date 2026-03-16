#!/bin/bash
set -e

DB_PATH="/var/lib/mysql/${SQL_DATABASE}"
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

echo "Root password is: $MYSQL_ROOT_PASSWORD"
echo "User password is: $MYSQL_PASSWORD"

# --- Si la base existe déjà, on ne refait pas l'initialisation
if [ -d "$DB_PATH" ]; then
    echo "✅ Database already exists, skipping initialization."
    exec mysqld_safe
fi

echo "🔧 First launch: initializing MariaDB..."

# Lancer MariaDB sans réseau
mysqld_safe --skip-networking &
sleep 5

# Créer la base et l'utilisateur
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"
mysql -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';"

# Définir le mot de passe root
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Arrêter l'instance temporaire proprement
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
echo "✅ Initialization complete!"
exec mysqld_safe
