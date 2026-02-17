FROM php:8.3-cli

# System deps + PHP extensions commonly required by Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        bcmath \
        curl \
        gd \
        intl \
        mbstring \
        pdo \
        pdo_mysql \
        zip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Node.js (LTS 22)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy app first so artisan/bootstrap exist for composer scripts
COPY . .

# Install PHP deps
RUN composer install --no-dev --optimize-autoloader

# Prepare app env + key for production
ENV APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stderr
RUN cp .env.example .env \
    && php artisan key:generate --force \
    && php artisan config:cache

# Install JS deps
RUN npm ci

# Build assets
RUN npm run build

# Expose port
EXPOSE 10000

# Run Laravel via built-in server
CMD ["sh", "-c", "php -S 0.0.0.0:${PORT:-10000} -t public"]
