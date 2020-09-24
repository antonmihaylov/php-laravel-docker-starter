FROM php:7.4-fpm-alpine

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html
RUN chmod o+rw /var/www/html


WORKDIR /var/www/html

RUN set -ex \
  && apk add \
    postgresql-dev

RUN docker-php-ext-install pdo pgsql pdo_pgsql
