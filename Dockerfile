# Usamos una imagen oficial de PHP con FPM
FROM php:8.2-fpm

# Instalar dependencias del sistema necesarias para Laravel y Nginx
RUN apt-get update && apt-get install -y \
    nginx \
    zip \
    unzip \
    git \
    libpng-dev \
    libonig-dev \
    libxml2-dev

# Instalar extensiones de PHP necesarias
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Definir el directorio de trabajo
WORKDIR /var/www/html

# Copiar todos los archivos de tu proyecto al contenedor
COPY . .

# Ajustar permisos para que Laravel pueda escribir en estas carpetas
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache && \
    chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Instalar las dependencias de PHP
RUN composer install --no-dev --optimize-autoloader

# --- AQUÍ ESTÁ EL AJUSTE PARA EL .env ---
# Si no existe un .env, creamos uno a partir del archivo de ejemplo
RUN if [ ! -f .env ]; then cp .env.example .env; fi

# Generar la llave de la aplicación
RUN php artisan key:generate

# Configurar Nginx
COPY nginx.conf /etc/nginx/sites-available/default

# Exponer el puerto 80 para el tráfico web
EXPOSE 80

# Iniciar Nginx y PHP-FPM
CMD service nginx start && php-fpm