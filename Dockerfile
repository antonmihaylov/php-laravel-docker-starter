FROM php:7.4-fpm-alpine

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev

RUN docker-php-ext-install pdo pdo_pgsql

## Arguments defined in docker-compose.yml
#ARG user
#ARG uid
#
## Install system dependencies
#RUN apt-get update && apt-get install -y \
#    git \
#    curl \
#    zip \
#    unzip \
#    libpq-dev \
#    zlib1g-dev \
#    libpng-dev
#
#
## Clear cache
#RUN apt-get clean && rm -rf /var/lib/apt/lists/*
#
## Install PHP extensions
#RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
#RUN docker-php-ext-install pgsql pdo_pgsql mbstring exif pcntl bcmath gd
#
## Install laravel cli
#RUN composer global require laravel/installer
#
## Get latest Composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
#
## Create system user to run Composer and Artisan Commands
#RUN useradd -G www-data,root -u $uid -d /home/$user $user
#RUN mkdir -p /home/$user/.composer && \
#    chown -R $user:$user /home/$user
#
## Set working directory
#WORKDIR /var/www
#
#USER $user