FROM php:7.1.2-apache

RUN apt-get -yqq update \
    && apt-get -yqq install --no-install-recommends unzip \
    && curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Cache composer dependencies
WORKDIR /tmp
ADD app/composer.json app/composer.lock /tmp/
RUN mkdir -p database/ \
    && composer install \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist \
    && rm -rf composer.json composer.lock database/ vendor/

# Now add the project
ADD app /var/www/html
WORKDIR /var/www/html

# Install composer in the project from cache
RUN composer install \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist
