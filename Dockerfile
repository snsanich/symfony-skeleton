FROM php:7.0-fpm

RUN apt-get update && \
    apt-get install -y libmcrypt-dev libpq-dev netcat

RUN docker-php-ext-install \
        mcrypt \
        bcmath \
        mbstring \
        zip \
        opcache \
        pdo pdo_pgsql

RUN pecl install apcu xdebug

COPY . /srv/

WORKDIR /srv
CMD ["bash", "boot.sh"]
