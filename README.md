[![](https://images.microbadger.com/badges/image/tlnk/lychee.svg)](https://microbadger.com/images/tlnk/lychee "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/tlnk/lychee.svg)](https://microbadger.com/images/tlnk/lychee "Get your own version badge on microbadger.com")

# Lychee

![Screenshot](https://camo.githubusercontent.com/89386c42bade1e05e9de57d8d4f74bee699ffeab/687474703a2f2f6c2e656c6563746572696f75732e636f6d2f75706c6f6164732f6269672f63346235386362383764393561656165643738666463613538316363393038632e6a7067)

# Supported tags and respective

* latest [Dockerfile](https://github.com/tle06/Lychee/blob/master/Dockerfile)

This image is updated via pull requests to the tle06/lychee GitHub repo.

# Sources
[github/lychee](https://github.com/electerious/Lychee)

# What is lychee
Lychee is a free photo-management tool, which runs on your server or web-space. Installing is a matter of seconds. Upload, manage and share photos like from a native application. Lychee comes with everything you need and all your photos are stored securely.

# Image configuration
## Package installed
* git
* apt-transport-https
* apache2
* libapache2-mod-php
* php-gd
* php-json
* php-mysql
* php-curl
* php-zip
* php-mbstring

## Port exposed
* port 80

## Work dir
* workdir = /var/www/lychee

# Available ENV variable

* __FLOOD_BASEURI__ =/
* __FLOOD_DBCLEANINTERVAL__ =1000*60*60
* __FLOOD_DBPATH__ =./server/db/
* __FLOOD_FLOODSERVERHOST__ =127.0.0.1
* __FLOOD_FLOODSERVERPORT__ =3000
* __FLOOD_MAXHISTORYSTATES__ =30
* __FLOOD_POLLINTERVAL__ =1000*5
* __FLOOD_SECRET=__ flood
* __FLOOD_SCGIHOST__ =localhost
* __FLOOD_SCGIPORT__ =5000
* __FLOOD_SCGISOCKET__ =false
* __FLOOD_SCGISOCKETPATCH__ =/tmp/rtorrent.sock
* __FLOOD_SSL__ =false
* __FLOOD_SSLKEY__ =/absolute/path/to/key/
* __FLOOD_SSLCERT__ =/absolute/path/to/certificate/
* __FLOOD_TORRENTCLIENTPOLLINTERVAL__ =1000*2

* __PHP_UPLOAD_MAX_FILESIZE__ =100M
* __PHP_POST_MAX_SIZE__ =100M
* __PHP_MAX_EXCUTION_TIME__ =200
* __PHP_MEMORY_LIMIT__ =256M

# How to use this image
## Start lychee

Starting the lychee instance listening on port 80 is as easy as the following:
``` Docker

$ docker run -d --restart=always -p 80:80 tlnk/lychee

```
Then go to http://localhost/ and go through the wizard.

## Persistent data

* -v /`<mydatalocation>`:/uploads (Save all upload from lychee)
* -v /`<mydatalocation>`:/data (save configuration file from lychee)

## Via docker-compose

```
Docker
version: '2'

services:

lychee:
 image: tlnk/lychee
 ports:
   - 80:80

```
