FROM php:8.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    nginx \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar directorio
WORKDIR /var/www
COPY . .

# Crear carpetas y permisos necesarios
RUN mkdir -p /var/www/storage /var/www/bootstrap/cache && \
    chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache /var/www/public

# Configurar Nginx
COPY ./nginx.conf /etc/nginx/sites-available/default

# Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

EXPOSE 80
CMD service nginx start && php-fpm