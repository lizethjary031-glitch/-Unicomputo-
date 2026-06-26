FROM php:8.2-fpm

RUN apt-get update && apt-get install -y nginx zip unzip git && \
    docker-php-ext-install pdo pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY unicomputo/unicomputo/ .

# Permisos estándar de Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

RUN composer install --no-dev --optimize-autoloader

COPY nginx.conf /etc/nginx/sites-available/default

EXPOSE 80
CMD service nginx start && php-fpm