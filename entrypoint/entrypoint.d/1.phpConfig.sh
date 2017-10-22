#!/usr/bin/bash
#Default value
PHP_UPLOAD_MAX_FILESIZE="${PHP_UPLOAD_MAX_FILESIZE:=100M}"
PHP_POST_MAX_SIZE="${PHP_POST_MAX_SIZE:=100M}"
PHP_MAX_EXCUTION_TIME="${PHP_MAX_EXCUTION_TIME:=200}"
PHP_MEMORY_LIMIT="${PHP_MEMORY_LIMIT:=256M}"

#Set parameters
sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = $PHP_UPLOAD_MAX_FILESIZE/g" /etc/php/7.0/apache2/php.ini
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = $PHP_POST_MAX_SIZE/g" /etc/php/7.0/apache2/php.ini
sed -i -e "s/max_execution_time\s*=\s*30/max_execution_time = $PHP_MAX_EXCUTION_TIME/g" /etc/php/7.0/apache2/php.ini
sed -i -e "s/memory_limit\s*=\s*128M/memory_limit = $PHP_MEMORY_LIMIT/g" /etc/php/7.0/apache2/php.ini