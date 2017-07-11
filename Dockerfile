FROM php:5.6-apache
MAINTAINER Michał Szczech <m.szczech@hotmail.com>

# Setup timezone
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "date.timezone=$TZ" >> /usr/local/etc/php/conf.d/default.ini

# Update sources
RUN apt-get update -y

# Install "mod_rewrite" – http://httpd.apache.org/docs/current/mod/mod_rewrite.html
RUN a2enmod rewrite

# Install "mod_headers" – http://httpd.apache.org/docs/current/mod/mod_headers.html
RUN a2enmod headers

# Install "mod_expires" – http://httpd.apache.org/docs/current/mod/mod_expires.html
RUN a2enmod expires

# Install "Git" – https://git-scm.com/
RUN apt-get install -y git

# Install "Composer" – https://getcomposer.org/
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Midnight Commander, Vim, Nano
RUN apt-get install -y mc vim nano

#Install "mysql-client" – https://dev.mysql.com/doc/refman/5.7/en/mysql.html
RUN apt-get install -y mysql-client

# Install "ImageMagick" executable – https://www.imagemagick.org/script/index.php
RUN apt-get install -y imagemagick

# Install PHP "gd" extension
RUN apt-get install -y libjpeg-dev libpng12-dev
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Install PHP "curl" extension – http://php.net/manual/en/book.curl.php
RUN apt-get install -y zlib1g-dev libicu-dev g++
RUN apt-get install -y libcurl4-openssl-dev
RUN docker-php-ext-install curl

# Install PHP "intl" extension – http://php.net/manual/en/book.intl.php
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

# Install PHP "xsl" extension – http://php.net/manual/en/book.xsl.php
RUN apt-get install -y libxslt-dev
RUN docker-php-ext-install xsl

# Install PHP "exif" extension – http://php.net/manual/en/book.exif.php
RUN apt-get install -y libexif-dev
RUN docker-php-ext-install exif

# Install PHP "mysql" extension – http://php.net/manual/pl/book.mysql.php
RUN docker-php-ext-install mysql

# Install PHP "mysqli" extension – http://php.net/manual/pl/book.mysqli.php
RUN docker-php-ext-install mysqli

# Install PHP "pdo" extension – http://php.net/manual/pl/book.pdo.php
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql pdo_sqlite

# Install PHP "opcache" extension – http://php.net/manual/en/book.opcache.php
RUN docker-php-ext-install opcache

# Install PHP "zip" extension – http://php.net/manual/en/book.zip.php
RUN apt-get install -y zlib1g-dev
RUN docker-php-ext-install zip

# Cleanup the image
RUN rm -rf /var/lib/apt/lists/* /tmp/*