FROM php:8.2-fpm

# Instalar dependencias
RUN apt-get update && apt-get install -y nginx libpng-dev libjpeg-dev libfreetype6-dev zip unzip git && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Nos ubicamos en la carpeta donde está TODO el código de Laravel
WORKDIR /var/www/unicomputo/unicomputo
COPY . .

# Ajustamos permisos solo de las carpetas que SIEMPRE existen en Laravel
RUN mkdir -p storage bootstrap/cache && \
    chown -R www-data:www-data storage bootstrap/cache

# Instalar dependencias
RUN composer install --no-dev --optimize-autoloader

# Copiamos la configuración de Nginx (asegúrate que el archivo esté en la raíz de tu repo)
COPY ../nginx.conf /etc/nginx/sites-available/default

EXPOSE 80
CMD service nginx start && php-fpm