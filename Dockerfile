FROM php:7.4-apache
RUN apt-get update && \
    apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libcurl4-openssl-dev \
    libicu-dev icu-devtools \
    libonig-dev libxml2-dev libzip-dev git && \
    pecl install mongodb
RUN docker-php-ext-install curl gd intl bcmath json mbstring mysqli pdo_mysql xml zip && \
    docker-php-ext-enable mongodb
COPY ./composerw /usr/local/bin/composerw
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer.phar && \
    chmod +x /usr/local/bin/composerw
