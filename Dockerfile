FROM php:8.2-apache

WORKDIR /var/www/html

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    git unzip curl libzip-dev zip \
    default-mysql-client \
    libonig-dev \
    libxml2-dev \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql mysqli zip

# Habilitar mod_rewrite de Apache
RUN a2enmod rewrite \
    && a2dismod mpm_event \
    && a2enmod mpm_prefork

# Copiar proyecto
COPY . .

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && php composer.phar install --no-dev --optimize-autoloader --ignore-platform-reqs
# Permisos
RUN chown -R www-data:www-data /var/www/html

# Puerto
EXPOSE 80

CMD ["apache2-foreground"]