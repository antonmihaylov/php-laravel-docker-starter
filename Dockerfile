FROM php:7.4-fpm-alpine

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev

RUN docker-php-ext-install pdo pgsql pdo_pgsql

## Install laravel cli
#RUN composer global require laravel/installer
#
## Get latest Composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
