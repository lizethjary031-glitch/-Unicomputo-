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

# Configurar directorio (Apuntando a tu carpeta)
WORKDIR /var/www/unicomputo
COPY . .

# Crear carpetas y permisos
RUN mkdir -p /var/www/unicomputo/storage /var/www/unicomputo/bootstrap/cache && \
    chown -R www-data:www-data /var/www/unicomputo/storage /var/www/unicomputo/bootstrap/cache /var/www/unicomputo/public

# Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Configurar Nginx
COPY nginx.conf /etc/nginx/sites-available/default

EXPOSE 80
CMD service nginx start && php-fpm