FROM composer:latest

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

## Install laravel cli
RUN composer global require laravel/installer

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html
