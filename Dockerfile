FROM php:8.2-cli

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git unzip curl libzip-dev zip \
    default-mysql-client \
    libonig-dev \
    libxml2-dev \
    libsqlite3-dev \
    && docker-php-ext-install zip pdo pdo_mysql mysqli

RUN curl -sS https://getcomposer.org/installer | php

COPY . .

RUN php composer.phar install --no-dev --optimize-autoloader

# Verificación
RUN php -m | grep -E "pdo|mysql"

EXPOSE 8080

CMD php artisan serve --host=0.0.0.0 --port=8080