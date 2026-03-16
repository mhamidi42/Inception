# Utiliser la dernière version stable de Debian (autorisée)
FROM debian:bookworm

# Mettre à jour le système et installer MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Copier le fichier de configuration MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copier le script d’initialisation
COPY tools/dbscript.sh /usr/local/bin/

# Donner les droits d’exécution au script
RUN chmod +x /usr/local/bin/dbscript.sh

# Exposer le port MariaDB
EXPOSE 3350

# Lancer le script d’initialisation au démarrage du container
ENTRYPOINT ["/usr/local/bin/dbscript.sh"]
