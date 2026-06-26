FROM php:8.2-fpm

# Instalar dependencias
RUN apt-get update && apt-get install -y nginx libpng-dev libjpeg-dev libfreetype6-dev zip unzip git && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Cambiamos el WORKDIR a la carpeta donde realmente está tu código
WORKDIR /var/www/unicomputo/unicomputo
COPY . .

# Ahora las rutas serán correctas
RUN mkdir -p storage bootstrap/cache && \
    chown -R www-data:www-data storage bootstrap/cache public

# Instalar dependencias
RUN composer install --no-dev --optimize-autoloader

# Copiamos nginx.conf desde la raíz (fuera de la subcarpeta)
COPY ../nginx.conf /etc/nginx/sites-available/default

EXPOSE 80
CMD service nginx start && php-fpm