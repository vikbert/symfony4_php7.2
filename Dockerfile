# PHP 7.2 image with php cli, fpm, memcache, maxmind, mongo and blackfire extensions
FROM phusion/baseimage:latest

# Set the env variable DEBIAN_FRONTEND to noninteractive
#ARG DEBIAN_FRONTEND=noninteractive
#ARG LC_ALL=C.UTF-8

RUN add-apt-repository -y ppa:ondrej/php && \
    curl https://packagecloud.io/gpg.key | apt-key add - && \
    echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    locales \
    ca-certificates \
    curl \
    zip \
    memcached \
    php-pear \
    php-memcache \
    php-redis \
    php7.2 \
    php7.2-common \
    php7.2-json \
    php7.2-opcache \
    php7.2-readline \
    php7.2-cli \
    php7.2-curl \
    php7.2-dev \
    php7.2-fpm \
    php7.2-gd \
    php7.2-gmp \
    php7.2-intl \
    php7.2-json \
    php7.2-mbstring \
    php7.2-oauth \
    php7.2-opcache \
    php7.2-xml \
    php7.2-zip \
    php7.2-yaml \
    php7.2-mysql \
    nginx \
    vim \
    blackfire-agent blackfire-php

RUN set -ex; \
        apt-get update; \
        useradd nginx && mkdir -p /var/lib/php/session && chgrp nginx /var/lib/php/session; \
        curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin; \
        composer global require hirak/prestissimo; \
        locale-gen en_US; \
        mkdir -p /etc/ssl/certs/ && update-ca-certificates --fresh; \
        apt-get purge -y --auto-remove && apt-get clean all && rm -rf /var/lib/apt/*; \
        /etc/init.d/memcached start;

ADD ./build/nginx.conf /etc/nginx/sites-enabled/default
ADD ./application /var/www/appliction
WORKDIR /var/www/application
CMD service php7.2-fpm start; nginx -g 'daemon off;'
