FROM php:8.2-fpm

RUN apt-get update && apt-get install -y nginx zip unzip git && \
    docker-php-ext-install pdo pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

# Permisos necesarios para que Laravel escriba en caché y logs
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache && \
    chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Instalar dependencias
RUN composer install --no-dev --optimize-autoloader

# Crear llave de aplicación si no existe (vital para sesiones)
RUN php artisan key:generate

COPY nginx.conf /etc/nginx/sites-available/default

EXPOSE 80
CMD service nginx start && php-fpm