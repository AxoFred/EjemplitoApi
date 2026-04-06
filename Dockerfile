FROM php:8.2-cli

WORKDIR /app

# Dependencias
RUN apt-get update && apt-get install -y \
    git unzip curl libzip-dev zip \
    default-mysql-client \
    libonig-dev \
    libxml2-dev \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql mysqli zip

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php

# Copiar proyecto
COPY . .

# Instalar Laravel
RUN php composer.phar install --no-dev --optimize-autoloader --ignore-platform-reqs

# Puerto Railway
EXPOSE 8080

# Servidor Laravel
CMD php artisan serve --host=0.0.0.0 --port=8080