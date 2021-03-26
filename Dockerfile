FROM php:fpm-alpine as fpm

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions \
    opcache

COPY ./etc/php.ini /usr/local/etc/php/conf.d/zz-custom.ini
COPY ./etc/fpm.conf /usr/local/etc/php-fpm.d/zz-custom.conf

WORKDIR /var/www

COPY --from=composer /usr/bin/composer /usr/local/bin/composer
COPY --chown=www-data:www-data ./ ./

RUN APP_ENV=prod composer install --prefer-dist --no-dev --classmap-authoritative --no-interaction
RUN composer symfony:dump-env --no-interaction prod



FROM nginx:alpine as nginx

COPY --from=fpm --chown=www-data:www-data /var/www/public /var/www/public

COPY ./etc/nginx.conf /etc/nginx/conf.d/fpm.conf
