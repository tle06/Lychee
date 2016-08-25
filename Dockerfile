#Dockerfile lychee
FROM ubuntu:14.04
MAINTAINER tlnk <support@tlnk.fr>

ENV PHP_UPLOAD_MAX_FILESIZE 100M
ENV PHP_POST_MAX_SIZE 100M
ENV PHP_MAX_EXCUTION_TIME 200
ENV PHP_MEMORY_LIMIT 256M

#Install source + packages
RUN \
export LANG=C.UTF-8 && \
apt-get update && \
apt-get upgrade -y && \
apt-get install -y \
apt-transport-https \
nano \
wget \
unzip \
apache2 \
php5-cli \
php5-gd \
php5-common \
php5-mysql \
php5-curl && \
rm -rf /var/lib/apt/lists/* && \
mkdir /App

#Setup site.conf and app
COPY . /App
COPY lychee.conf /etc/apache2/sites-available/lychee.conf

RUN  mkdir /var/www/lychee && \
cp -r /App/* /var/www/lychee/ && \
chown -R www-data:www-data /var/www/lychee/ && \
chmod -R 777 /var/www/lychee/uploads /var/www/lychee/data

#edit php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = $PHP_UPLOAD_MAX_FILESIZE/g" /etc/php5/apache2/php.ini && \
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = $PHP_POST_MAX_SIZE/g" /etc/php5/apache2/php.ini && \
sed -i -e "s/max_execution_time\s*=\s*30/max_execution_time = $PHP_MAX_EXCUTION_TIME/g" /etc/php5/apache2/php.ini && \
sed -i -e "s/memory_limit\s*=\s*128M/memory_limit = $PHP_MEMORY_LIMIT/g" /etc/php5/apache2/php.ini

#edit config.php
# RUN  sed -i -e "s/$dbHost =\s*''/$dbHost = '$MYSQL_HOST'/g" /var/www/leechy/data/config.php && \
# sed -i -e "s/$dbUser =\s*''/$dbUser =  '$MYSQL_USERNAME'/g" /var/www/leechy/data/config.php && \
# sed -i -e "s/$dbPassword =\s*''/$dbPassword = '$MYSQL_PASSWORD'/g" /var/www/leechy/data/config.php && \
# sed -i -e "s/$dbName =\s*''/$dbName = '$MYSQL_DB_NAME'/g" /var/www/leechy/data/config.php

#Load apache module
RUN a2enmod rewrite && \
ln -s /etc/apache2/sites-available/lychee.conf /etc/apache2/sites-enabled/lychee.conf && \
echo "serverName localhost" >> /etc/apache2/apache2.conf

#Cleaning
RUN rm /etc/apache2/sites-enabled/000-default.conf && \
rm -rf /App && \
apt-get clean && \
service apache2 restart


WORKDIR /var/www/lychee
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
