FROM php:8.4-cli

WORKDIR /app

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    git unzip curl libzip-dev zip \
    && docker-php-ext-install zip

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php

# Copiar proyecto
COPY . .

# Instalar dependencias
RUN php composer.phar install --no-dev --optimize-autoloader

# Exponer puerto
EXPOSE 8080

# Servidor (Laravel)
CMD php -S 0.0.0.0:8080 -t public