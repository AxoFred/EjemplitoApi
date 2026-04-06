FROM php:8.4-cli

WORKDIR /app

ARG CACHE_BUST=1
# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    git unzip curl libzip-dev zip \
    && docker-php-ext-install zip pdo pdo_mysql \
    && echo "build mysql enabled"

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php

# Copiar proyecto
COPY . .

# Instalar dependencias de Laravel
RUN php composer.phar install --no-dev --optimize-autoloader

# Exponer puerto
EXPOSE 8080

# Servidor Laravel
CMD php artisan serve --host=0.0.0.0 --port=8080

RUN php -m | grep pdo