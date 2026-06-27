FROM php:8.2-fpm

# Instalar dependencias
RUN apt-get update && apt-get install -y nginx zip unzip git && \
    docker-php-ext-install pdo pdo_mysql

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Directorio de trabajo
WORKDIR /var/www/html
COPY . .

# Ajustar permisos (Laravel requiere que 'storage' y 'bootstrap/cache' sean escribibles)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Instalar dependencias de PHP
RUN composer install --no-dev --optimize-autoloader

# Configurar Nginx
COPY nginx.conf /etc/nginx/sites-available/default

EXPOSE 80
CMD service nginx start && php-fpm