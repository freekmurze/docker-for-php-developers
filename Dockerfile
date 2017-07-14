FROM php:7.1.0-apache

MAINTAINER Freek
COPY .docker/php/php.ini /user/local/etc/php/
COPY . /srv
COPY .docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache
