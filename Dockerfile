FROM php:7.1.0-apache

MAINTAINER Freek
COPY .docker/php/php.ini /user/local/etc/php/
COPY . /srv
COPY .docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN docker-php-ext-install pdo_mysql opcache \
    && pecl install xdebug-2.5.1 \
    && docker-php-ext-enable xdebug

COPY .docker/php/xdebug-dev.ini /usr/local/etc/php/conf.d/xdebug-dev.ini
RUN chown -R www-data:www-data /srv/app
