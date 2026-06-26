FROM php:8.2-fpm

RUN apt-get update && apt-get install -y nginx libpng-dev libjpeg-dev libfreetype6-dev zip unzip git && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/unicomputo
COPY . .

# Diagnóstico: Esto nos mostrará en los logs si nginx.conf está realmente ahí
RUN ls -la /var/www/unicomputo/

RUN mkdir -p /var/www/unicomputo/storage /var/www/unicomputo/bootstrap/cache && \
    chown -R www-data:www-data /var/www/unicomputo/storage /var/www/unicomputo/bootstrap/cache /var/www/unicomputo/public

RUN composer install --no-dev --optimize-autoloader

# Copiamos usando la ruta completa
COPY nginx.conf /etc/nginx/sites-available/default

EXPOSE 80
CMD service nginx start && php-fpm