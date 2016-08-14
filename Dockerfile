#Dockerfile lychee
FROM ubuntu:14.04
MAINTAINER tlnk <support@tlnk.fr>

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
libapache2-mod-php5 \
php5-fpm \
php5-mysql \
php5-curl \
rm -rf /var/lib/apt/lists/* && \
mkdir /App

#Setup site.conf and app
COPY . /App
COPY lychee.conf /etc/apache2/sites-available/lychee.conf
RUN  \
mkdir /var/www/lychee && \
cp /App/* /var/www/lychee/ && \
chown -R www-data:www-data /var/www/lychee/

#edit php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/apache2/php.ini && \
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/apache2/php.ini

#Load apache module
RUN a2enmod rewrite \
 && ln -s /etc/apache2/sites-available/lychee.conf /etc/apache2/sites-enabled/lychee.conf

#Cleaning
RUN rm /etc/apache2/sites-enabled/000-default.conf \
 && rm lychee_Installer.zip \
 && rm /App \
 && apt-get clean \
 && service apache2 restart


WORKDIR /var/www/lychee
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
