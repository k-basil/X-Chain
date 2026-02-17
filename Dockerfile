FROM php:8.3-cli

# System deps
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Node.js (LTS 22)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install PHP deps
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# Install JS deps
COPY package.json package-lock.json ./
RUN npm ci

# Copy app
COPY . .

# Build assets
RUN npm run build

# Expose port
EXPOSE 10000

# Run Laravel via built-in server
CMD ["sh", "-c", "php -S 0.0.0.0:${PORT:-10000} -t public"]
