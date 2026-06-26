# 1. Usar una imagen oficial de PHP con FPM
FROM php:8.2-fpm

# 2. Instalar dependencias
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

# 3. Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Configurar directorio de trabajo
WORKDIR /var/www
COPY . .

# 5. CREAR CARPETAS Y PERMISOS (Solución al error anterior)
# Usamos -p para que no falle si ya existen y crearlas si no existen
RUN mkdir -p /var/www/storage /var/www/bootstrap/cache && \
    chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# 6. Configurar Nginx
COPY ./nginx.conf /etc/nginx/sites-available/default

# 7. Exponer puerto y comando de inicio (Corregido php-fpm)
EXPOSE 80
# Cambiamos el CMD para que intente arrancar Nginx en primer plano y ver el error en consola
CMD nginx -t && nginx && php-fpm