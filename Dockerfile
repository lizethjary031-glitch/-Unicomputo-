# 1. Usar una imagen oficial de PHP con FPM
FROM php:8.2-fpm

# 2. Instalar dependencias del sistema y extensiones de PHP necesarias para Laravel
RUN apt-get update && apt-get install -y \
    nginx \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# 3. Instalar Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Copiar código y configurar permisos
WORKDIR /var/www
COPY . .
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# 5. Configurar Nginx (crearemos este archivo luego)
COPY ./nginx.conf /etc/nginx/sites-available/default

# 6. Exponer puerto 80 y correr PHP-FPM y Nginx
EXPOSE 80
CMD service nginx start && php-fpm